import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/use_cases/income_statement_use_case.dart';
import 'package:ledger_app/ui/reports/bloc/reports_cubit.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  ReportsCubit buildCubit(FakeLedgerRepository repository) => ReportsCubit(
    incomeStatement: IncomeStatementUseCase(
      ledgerRepository: repository,
      now: () => fixtureToday,
    ),
  );

  final repository = FakeLedgerRepository(
    accounts: fixtureAccounts,
    transactions: fixtureTransactions,
  );

  blocTest<ReportsCubit, ReportsState>(
    'emits loading then the current month',
    build: () => buildCubit(repository),
    act: (cubit) => cubit.load(),
    expect: () => [
      const ReportsState(status: ReportsStatus.loading),
      isA<ReportsState>()
          .having((s) => s.status, 'status', ReportsStatus.success)
          .having((s) => s.statement?.month, 'month', DateTime(2026, 9)),
    ],
  );

  blocTest<ReportsCubit, ReportsState>(
    'moves back a month and forward again',
    build: () => buildCubit(repository),
    act: (cubit) async {
      await cubit.load();
      await cubit.previousMonth();
      await cubit.nextMonth();
    },
    skip: 2,
    verify: (cubit) => expect(cubit.state.statement?.month, DateTime(2026, 9)),
    expect: () => [
      isA<ReportsState>().having(
        (s) => s.status,
        'status',
        ReportsStatus.loading,
      ),
      isA<ReportsState>().having(
        (s) => s.statement?.month,
        'month',
        DateTime(2026, 8),
      ),
      isA<ReportsState>().having(
        (s) => s.status,
        'status',
        ReportsStatus.loading,
      ),
      isA<ReportsState>().having(
        (s) => s.statement?.month,
        'month',
        DateTime(2026, 9),
      ),
    ],
  );

  blocTest<ReportsCubit, ReportsState>(
    'does not go past the latest month',
    build: () => buildCubit(repository),
    act: (cubit) async {
      await cubit.load();
      await cubit.nextMonth();
    },
    skip: 2,
    expect: () => <ReportsState>[],
  );

  blocTest<ReportsCubit, ReportsState>(
    'does not go before the first transaction',
    build: () => buildCubit(repository),
    act: (cubit) async {
      await cubit.load();
      await cubit.previousMonth();
      await cubit.previousMonth();
    },
    skip: 4,
    expect: () => <ReportsState>[],
  );

  blocTest<ReportsCubit, ReportsState>(
    'emits failure when the ledger cannot be loaded',
    build: () => buildCubit(FakeLedgerRepository(error: Exception('disk'))),
    act: (cubit) => cubit.load(),
    expect: () => [
      const ReportsState(status: ReportsStatus.loading),
      const ReportsState(
        status: ReportsStatus.failure,
        error: ReportsError.loadFailed,
      ),
    ],
  );

  blocTest<ReportsCubit, ReportsState>(
    'drills from the overview into a side and back out',
    build: () => buildCubit(repository),
    act: (cubit) async {
      await cubit.load();
      cubit.openSide(ReportSide.expense);
      cubit.drillInto('Expenses:Food');
      cubit.back();
      cubit.back();
    },
    skip: 2,
    expect: () => [
      isA<ReportsState>().having((s) => s.side, 'side', ReportSide.expense),
      isA<ReportsState>()
          .having((s) => s.drill, 'drill', ['Expenses:Food'])
          .having((s) => s.trail.last.name, 'node', 'Food'),
      isA<ReportsState>().having((s) => s.drill, 'drill', <String>[]),
      isA<ReportsState>().having((s) => s.side, 'side', isNull),
    ],
  );

  blocTest<ReportsCubit, ReportsState>(
    'ignores a drill before a side is chosen',
    build: () => buildCubit(repository),
    act: (cubit) async {
      await cubit.load();
      cubit.drillInto('Expenses:Food');
      cubit.back();
    },
    skip: 2,
    expect: () => <ReportsState>[],
  );

  blocTest<ReportsCubit, ReportsState>(
    'returns to the overview when the month changes',
    build: () => buildCubit(repository),
    act: (cubit) async {
      await cubit.load();
      cubit.openSide(ReportSide.expense);
      await cubit.previousMonth();
    },
    verify: (cubit) {
      expect(cubit.state.side, isNull);
      expect(cubit.state.statement?.month, DateTime(2026, 8));
    },
  );

  blocTest<ReportsCubit, ReportsState>(
    'jumps from a drilled level straight to the overview',
    build: () => buildCubit(repository),
    act: (cubit) async {
      await cubit.load();
      cubit.openSide(ReportSide.expense);
      cubit.drillInto('Expenses:Food');
      cubit.showOverview();
    },
    skip: 4,
    expect: () => [
      isA<ReportsState>()
          .having((s) => s.side, 'side', isNull)
          .having((s) => s.drill, 'drill', <String>[]),
    ],
  );
}
