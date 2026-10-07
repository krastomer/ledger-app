import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/domain/use_cases/review_queue_use_case.dart';
import 'package:ledger_app/ui/inbox/bloc/inbox_cubit.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fakes/fake_slip_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

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
}
