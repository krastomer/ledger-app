import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/review_item.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/domain/use_cases/review_queue_use_case.dart';
import 'package:ledger_app/ui/inbox/bloc/inbox_cubit.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fakes/fake_slip_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

class _RejectingWrites extends FakeLedgerRepository {
  _RejectingWrites({super.accounts, super.transactions});

  @override
  Future<Result<void>> save(LedgerTransaction transaction) async =>
      Result.error(Exception('read only'));

  @override
  Future<Result<void>> delete(String id) async =>
      Result.error(Exception('read only'));
}

class _FailingPicker extends FakeSlipRepository {
  _FailingPicker() : super(const {});

  @override
  Future<Result<List<String>>> pickImages() async =>
      Result.error(Exception('no photos'));
}

void main() {
  late FakeLedgerRepository ledger;

  setUp(() {
    ledger = FakeLedgerRepository(
      accounts: fixtureAccounts,
      transactions: [
        ...fixtureTransactions,
        fixtureTransaction('bts again', DateTime(2026, 9, 28), {
          'Expenses:Transport': thb(5000),
          'Liabilities:Credit card': thb(-5000),
        }),
      ],
    );
  });

  InboxCubit build({List<String> picked = const []}) => InboxCubit(
    reviewQueue: ReviewQueueUseCase(ledgerRepository: ledger),
    editTransaction: EditTransactionUseCase(ledgerRepository: ledger),
    importSlip: ImportSlipUseCase(
      slipRepository: FakeSlipRepository(const {}, picked: picked),
      ledgerRepository: ledger,
    ),
  );

  blocTest<InboxCubit, InboxState>(
    'loads the review queue',
    build: build,
    act: (cubit) => cubit.load(),
    verify: (cubit) => expect(
      cubit.state.openItems.map((i) => i.transaction.id),
      ['rent', 'bts again'],
    ),
  );

  blocTest<InboxCubit, InboxState>(
    'confirming clears the entry and reloads without it',
    build: build,
    act: (cubit) async {
      await cubit.load();
      await cubit.confirm(cubit.state.openItems.first);
      await pumpEventQueue();
    },
    verify: (cubit) {
      expect(
        ledger.transactions.firstWhere((t) => t.id == 'rent').status,
        TransactionStatus.cleared,
      );
      expect(cubit.state.openItems.map((i) => i.transaction.id), ['bts again']);
      expect(cubit.state.resolved.map((i) => i.transaction.id), ['rent']);
    },
  );

  blocTest<InboxCubit, InboxState>(
    'dropping a duplicate deletes the later copy',
    build: build,
    act: (cubit) async {
      await cubit.load();
      await cubit.dropDuplicate(cubit.state.openItems.last);
    },
    verify: (_) => expect(
      ledger.transactions.map((t) => t.id),
      isNot(contains('bts again')),
    ),
  );

  blocTest<InboxCubit, InboxState>(
    'keeping a duplicate hides it for the session',
    build: build,
    act: (cubit) async {
      await cubit.load();
      cubit.keep(cubit.state.openItems.last);
    },
    verify: (cubit) {
      expect(cubit.state.openItems.map((i) => i.transaction.id), ['rent']);
      expect(ledger.transactions, hasLength(fixtureTransactions.length + 1));
    },
  );

  blocTest<InboxCubit, InboxState>(
    'hands picked slip images to the view once',
    build: () => build(picked: ['a.jpg', 'b.jpg']),
    act: (cubit) => cubit.pickSlips(),
    expect: () => [
      const InboxState(picked: ['a.jpg', 'b.jpg']),
      const InboxState(),
    ],
  );

  blocTest<InboxCubit, InboxState>(
    'picking nothing leaves the state alone',
    build: build,
    act: (cubit) => cubit.pickSlips(),
    expect: () => <InboxState>[],
  );

  blocTest<InboxCubit, InboxState>(
    'a failed photo pick reports an error',
    build: () => InboxCubit(
      reviewQueue: ReviewQueueUseCase(ledgerRepository: ledger),
      editTransaction: EditTransactionUseCase(ledgerRepository: ledger),
      importSlip: ImportSlipUseCase(
        slipRepository: _FailingPicker(),
        ledgerRepository: ledger,
      ),
    ),
    act: (cubit) => cubit.pickSlips(),
    expect: () => [const InboxState(error: InboxError.pickFailed)],
  );

  blocTest<InboxCubit, InboxState>(
    'reports a queue that cannot be loaded',
    build: () {
      ledger = FakeLedgerRepository(error: Exception('disk'));
      return build();
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const InboxState(status: InboxStatus.loading),
      const InboxState(
        status: InboxStatus.failure,
        error: InboxError.loadFailed,
      ),
    ],
  );

  blocTest<InboxCubit, InboxState>(
    'moves an uncategorized entry to the chosen account',
    build: () {
      ledger.transactions.add(
        fixtureTransaction('mystery', DateTime(2026, 9, 29), {
          'Expenses:Uncategorized': thb(1200),
          'Assets:Bank:KBank': thb(-1200),
        }),
      );
      return build();
    },
    act: (cubit) async {
      await cubit.load();
      final item = cubit.state.openItems.firstWhere(
        (i) => i.reason == ReviewReason.uncategorized,
      );
      await cubit.categorize(item, 'Expenses:Food');
      await pumpEventQueue();
    },
    verify: (cubit) {
      final mystery = ledger.transactions.firstWhere((t) => t.id == 'mystery');
      expect(mystery.postings.first.account, 'Expenses:Food');
      expect(cubit.state.resolved.map((i) => i.transaction.id), ['mystery']);
      expect(
        cubit.state.openItems.map((i) => i.reason),
        isNot(contains(ReviewReason.uncategorized)),
      );
    },
  );

  blocTest<InboxCubit, InboxState>(
    'categorizing an item that is not uncategorized does nothing',
    build: build,
    act: (cubit) async {
      await cubit.load();
      await cubit.categorize(cubit.state.openItems.first, 'Expenses:Food');
    },
    verify: (cubit) {
      expect(cubit.state.resolved, isEmpty);
      expect(cubit.state.error, isNull);
    },
  );

  group('when the ledger rejects changes', () {
    setUp(() {
      ledger = _RejectingWrites(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      );
    });

    blocTest<InboxCubit, InboxState>(
      'a failed confirm keeps the item open and reports the error',
      build: build,
      act: (cubit) async {
        await cubit.load();
        await cubit.confirm(cubit.state.openItems.first);
      },
      verify: (cubit) {
        expect(cubit.state.error, InboxError.actionFailed);
        expect(cubit.state.resolved, isEmpty);
        expect(cubit.state.openItems, hasLength(1));
      },
    );

    blocTest<InboxCubit, InboxState>(
      'reports every failed attempt, not just the first',
      build: build,
      act: (cubit) async {
        await cubit.load();
        final item = cubit.state.openItems.first;
        await cubit.confirm(item);
        await cubit.confirm(item);
      },
      verify: (cubit) {},
      expect: () => [
        isA<InboxState>().having(
          (s) => s.status,
          'status',
          InboxStatus.loading,
        ),
        isA<InboxState>().having(
          (s) => s.status,
          'status',
          InboxStatus.success,
        ),
        isA<InboxState>().having(
          (s) => s.error,
          'error',
          InboxError.actionFailed,
        ),
        isA<InboxState>().having((s) => s.error, 'error', isNull),
        isA<InboxState>().having(
          (s) => s.error,
          'error',
          InboxError.actionFailed,
        ),
      ],
    );
  });
}
