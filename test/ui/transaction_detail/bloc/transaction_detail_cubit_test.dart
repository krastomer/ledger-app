import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/domain/use_cases/transaction_detail_use_case.dart';
import 'package:ledger_app/ui/transaction_detail/bloc/transaction_detail_cubit.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

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
}
