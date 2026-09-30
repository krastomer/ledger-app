import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/transaction_filter.dart';
import 'package:ledger_app/domain/use_cases/month_transactions_use_case.dart';
import 'package:ledger_app/ui/transactions/bloc/transactions_cubit.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  TransactionsCubit buildCubit(FakeLedgerRepository repository) =>
      TransactionsCubit(
        monthTransactions: MonthTransactionsUseCase(
          ledgerRepository: repository,
          now: () => fixtureToday,
        ),
      );

  final repository = FakeLedgerRepository(
    accounts: fixtureAccounts,
    transactions: fixtureTransactions,
  );

  Matcher loaded({DateTime? month, TransactionFilter? filter, int? days}) =>
      isA<TransactionsState>()
          .having((s) => s.status, 'status', TransactionsStatus.success)
          .having((s) => s.data?.month, 'month', month ?? DateTime(2026, 9))
          .having(
            (s) => s.filter,
            'filter',
            filter ?? const TransactionFilter(),
          )
          .having((s) => s.data?.days.length, 'days', days ?? isNotNull);

  blocTest<TransactionsCubit, TransactionsState>(
    'emits loading then the current month',
    build: () => buildCubit(repository),
    act: (cubit) => cubit.load(),
    expect: () => [
      const TransactionsState(status: TransactionsStatus.loading),
      loaded(days: 3),
    ],
  );

  blocTest<TransactionsCubit, TransactionsState>(
    'moves back a month and does not go before the first transaction',
    build: () => buildCubit(repository),
    act: (cubit) async {
      await cubit.load();
      await cubit.previousMonth();
      await cubit.previousMonth();
    },
    skip: 2,
    expect: () => [
      isA<TransactionsState>().having(
        (s) => s.status,
        'status',
        TransactionsStatus.loading,
      ),
      loaded(month: DateTime(2026, 8), days: 2),
    ],
  );

  blocTest<TransactionsCubit, TransactionsState>(
    'does not go past the latest month',
    build: () => buildCubit(repository),
    act: (cubit) async {
      await cubit.load();
      await cubit.nextMonth();
    },
    skip: 2,
    expect: () => <TransactionsState>[],
  );

  blocTest<TransactionsCubit, TransactionsState>(
    'reloads with the search query',
    build: () => buildCubit(repository),
    act: (cubit) async {
      await cubit.load();
      await cubit.setQuery('lunch');
    },
    skip: 2,
    verify: (cubit) {
      expect(cubit.state.filter.query, 'lunch');
      expect(cubit.state.data?.days.single.transactions.single.id, 'lunch');
    },
    expect: () => [
      isA<TransactionsState>().having((s) => s.filter.query, 'query', 'lunch'),
      isA<TransactionsState>().having(
        (s) => s.status,
        'status',
        TransactionsStatus.loading,
      ),
      loaded(filter: const TransactionFilter(query: 'lunch'), days: 1),
    ],
  );

  blocTest<TransactionsCubit, TransactionsState>(
    'toggles the pending and slip filters',
    build: () => buildCubit(repository),
    act: (cubit) async {
      await cubit.togglePendingOnly();
      await cubit.toggleWithSlipOnly();
    },
    verify: (cubit) => expect(
      cubit.state.filter,
      const TransactionFilter(pendingOnly: true, withSlipOnly: true),
    ),
    expect: () => isNotEmpty,
  );

  blocTest<TransactionsCubit, TransactionsState>(
    'emits failure when the ledger cannot be loaded',
    build: () => buildCubit(FakeLedgerRepository(error: Exception('disk'))),
    act: (cubit) => cubit.load(),
    expect: () => [
      const TransactionsState(status: TransactionsStatus.loading),
      const TransactionsState(
        status: TransactionsStatus.failure,
        error: TransactionsError.loadFailed,
      ),
    ],
  );
}
