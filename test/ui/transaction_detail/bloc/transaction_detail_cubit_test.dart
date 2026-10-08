import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/domain/use_cases/transaction_detail_use_case.dart';
import 'package:ledger_app/ui/transaction_detail/bloc/transaction_detail_cubit.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
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

void main() {
  late FakeLedgerRepository ledger;

  setUp(() {
    ledger = FakeLedgerRepository(
      accounts: fixtureAccounts,
      transactions: fixtureTransactions,
    );
  });

  TransactionDetailCubit build(String id) => TransactionDetailCubit(
    id: id,
    transactionDetail: TransactionDetailUseCase(ledgerRepository: ledger),
    editTransaction: EditTransactionUseCase(ledgerRepository: ledger),
  );

  blocTest<TransactionDetailCubit, TransactionDetailState>(
    'loads the entry and its summary',
    build: () => build('rent'),
    act: (cubit) => cubit.load(),
    verify: (cubit) {
      expect(cubit.state.status, TransactionDetailStatus.success);
      expect(cubit.state.detail?.summary.amount, thb(800000));
    },
  );

  blocTest<TransactionDetailCubit, TransactionDetailState>(
    'reports an entry that no longer exists',
    build: () => build('gone'),
    act: (cubit) => cubit.load(),
    expect: () => [
      const TransactionDetailState(status: TransactionDetailStatus.notFound),
    ],
  );

  blocTest<TransactionDetailCubit, TransactionDetailState>(
    'confirming marks the entry cleared',
    build: () => build('rent'),
    act: (cubit) async {
      await cubit.load();
      await cubit.confirm();
    },
    verify: (cubit) => expect(
      cubit.state.detail?.transaction.status,
      TransactionStatus.cleared,
    ),
  );

  blocTest<TransactionDetailCubit, TransactionDetailState>(
    'deleting removes the entry',
    build: () => build('rent'),
    act: (cubit) async {
      await cubit.load();
      await cubit.delete();
    },
    verify: (cubit) {
      expect(cubit.state.status, TransactionDetailStatus.deleted);
      expect(ledger.transactions.map((t) => t.id), isNot(contains('rent')));
    },
  );

  group('when the ledger rejects changes', () {
    setUp(() {
      ledger = _RejectingWrites(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      );
    });

    blocTest<TransactionDetailCubit, TransactionDetailState>(
      'a failed confirm keeps the entry and reports the error',
      build: () => build('rent'),
      act: (cubit) async {
        await cubit.load();
        await cubit.confirm();
      },
      verify: (cubit) {
        expect(cubit.state.error, TransactionDetailError.saveFailed);
        expect(cubit.state.status, TransactionDetailStatus.success);
        expect(
          cubit.state.detail?.transaction.status,
          TransactionStatus.pending,
        );
      },
    );

    blocTest<TransactionDetailCubit, TransactionDetailState>(
      'a failed delete keeps the entry and reports the error',
      build: () => build('rent'),
      act: (cubit) async {
        await cubit.load();
        await cubit.delete();
      },
      verify: (cubit) {
        expect(cubit.state.error, TransactionDetailError.saveFailed);
        expect(cubit.state.status, TransactionDetailStatus.success);
      },
    );

    blocTest<TransactionDetailCubit, TransactionDetailState>(
      'reports every failed attempt, not just the first',
      build: () => build('rent'),
      act: (cubit) async {
        await cubit.load();
        await cubit.confirm();
        await cubit.confirm();
        await cubit.delete();
      },
      verify: (cubit) {},
      expect: () => [
        isA<TransactionDetailState>().having(
          (s) => s.detail,
          'detail',
          isNotNull,
        ),
        isA<TransactionDetailState>().having(
          (s) => s.error,
          'error',
          TransactionDetailError.saveFailed,
        ),
        isA<TransactionDetailState>().having((s) => s.error, 'error', isNull),
        isA<TransactionDetailState>().having(
          (s) => s.error,
          'error',
          TransactionDetailError.saveFailed,
        ),
        isA<TransactionDetailState>().having((s) => s.error, 'error', isNull),
        isA<TransactionDetailState>().having(
          (s) => s.error,
          'error',
          TransactionDetailError.saveFailed,
        ),
      ],
    );
  });

  blocTest<TransactionDetailCubit, TransactionDetailState>(
    'reports a ledger that cannot be read',
    build: () {
      ledger = FakeLedgerRepository(error: Exception('disk'));
      return build('rent');
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const TransactionDetailState(
        status: TransactionDetailStatus.failure,
        error: TransactionDetailError.loadFailed,
      ),
    ],
  );

  blocTest<TransactionDetailCubit, TransactionDetailState>(
    'a confirm that succeeds clears an earlier error',
    build: () => build('rent'),
    seed: () => const TransactionDetailState(
      status: TransactionDetailStatus.success,
      error: TransactionDetailError.saveFailed,
    ),
    act: (cubit) => cubit.confirm(),
    verify: (cubit) {
      expect(cubit.state.error, isNull);
      expect(cubit.state.detail?.transaction.status, TransactionStatus.cleared);
    },
  );
}
