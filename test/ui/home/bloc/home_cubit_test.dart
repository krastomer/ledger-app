import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/use_cases/home_summary_use_case.dart';
import 'package:ledger_app/ui/home/bloc/home_cubit.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  HomeCubit buildCubit(FakeLedgerRepository repository) => HomeCubit(
    homeSummary: HomeSummaryUseCase(
      ledgerRepository: repository,
      now: () => fixtureToday,
    ),
  );

  blocTest<HomeCubit, HomeState>(
    'emits loading then success with the summary',
    build: () => buildCubit(
      FakeLedgerRepository(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      ),
    ),
    act: (cubit) => cubit.load(),
    expect: () => [
      const HomeState(status: HomeStatus.loading),
      isA<HomeState>()
          .having((s) => s.status, 'status', HomeStatus.success)
          .having((s) => s.summary?.netWorth, 'netWorth', thb(14025000))
          .having((s) => s.error, 'error', isNull),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'emits failure when the ledger cannot be loaded',
    build: () => buildCubit(FakeLedgerRepository(error: Exception('disk'))),
    act: (cubit) => cubit.load(),
    expect: () => [
      const HomeState(status: HomeStatus.loading),
      const HomeState(status: HomeStatus.failure, error: HomeError.loadFailed),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'toggles hidden amounts',
    build: () => buildCubit(FakeLedgerRepository()),
    act: (cubit) => cubit
      ..toggleAmountsHidden()
      ..toggleAmountsHidden(),
    expect: () => [const HomeState(amountsHidden: true), const HomeState()],
  );

  test('can start with amounts hidden', () {
    final cubit = HomeCubit(
      homeSummary: HomeSummaryUseCase(ledgerRepository: FakeLedgerRepository()),
      amountsHidden: true,
    );

    expect(cubit.state.amountsHidden, isTrue);
  });
}
