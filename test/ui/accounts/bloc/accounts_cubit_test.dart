import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/use_cases/accounts_summary_use_case.dart';
import 'package:ledger_app/ui/accounts/bloc/accounts_cubit.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  AccountsCubit buildCubit(FakeLedgerRepository repository) => AccountsCubit(
    accountsSummary: AccountsSummaryUseCase(
      ledgerRepository: repository,
      now: () => fixtureToday,
    ),
  );

  final repository = FakeLedgerRepository(
    accounts: fixtureAccounts,
    transactions: fixtureTransactions,
  );

  blocTest<AccountsCubit, AccountsState>(
    'loads and opens assets and liabilities two levels',
    build: () => buildCubit(repository),
    act: (cubit) => cubit.load(),
    verify: (cubit) {
      expect(cubit.state.status, AccountsStatus.success);
      expect(
        cubit.state.expanded,
        {
          'Assets',
          'Assets:Bank',
          'Liabilities',
        }.intersection(cubit.state.expanded),
      );
      expect(cubit.state.expanded, contains('Assets:Bank'));
      expect(cubit.state.expanded, isNot(contains('Expenses')));
    },
  );

  blocTest<AccountsCubit, AccountsState>(
    'toggles an account open and closed',
    build: () => buildCubit(repository),
    act: (cubit) async {
      await cubit.load();
      cubit.toggle('Expenses');
      cubit.toggle('Expenses');
    },
    skip: 2,
    expect: () => [
      isA<AccountsState>().having(
        (s) => s.expanded,
        'expanded',
        contains('Expenses'),
      ),
      isA<AccountsState>().having(
        (s) => s.expanded,
        'expanded',
        isNot(contains('Expenses')),
      ),
    ],
  );

  blocTest<AccountsCubit, AccountsState>(
    'keeps the open accounts when reloading',
    build: () => buildCubit(repository),
    act: (cubit) async {
      await cubit.load();
      cubit.toggle('Expenses');
      await cubit.load();
    },
    verify: (cubit) => expect(cubit.state.expanded, contains('Expenses')),
  );

  blocTest<AccountsCubit, AccountsState>(
    'switches the view',
    build: () => buildCubit(repository),
    act: (cubit) => cubit.setMode(AccountsMode.monthChange),
    expect: () => [const AccountsState(mode: AccountsMode.monthChange)],
  );

  blocTest<AccountsCubit, AccountsState>(
    'emits failure when the ledger cannot be loaded',
    build: () => buildCubit(FakeLedgerRepository(error: Exception('disk'))),
    act: (cubit) => cubit.load(),
    expect: () => [
      const AccountsState(status: AccountsStatus.loading),
      const AccountsState(
        status: AccountsStatus.failure,
        error: AccountsError.loadFailed,
      ),
    ],
  );
}
