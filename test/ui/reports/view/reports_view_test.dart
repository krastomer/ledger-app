import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/models/account_node.dart';
import 'package:ledger_app/domain/models/income_statement.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/core/themes/app_theme.dart';
import 'package:ledger_app/ui/reports/bloc/reports_cubit.dart';
import 'package:ledger_app/ui/reports/view/reports_view.dart';
import 'package:ledger_app/ui/reports/widgets/allocation_rows.dart';
import 'package:ledger_app/ui/reports/widgets/donut_chart.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/fakes/fake_settings_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

class _MockReportsCubit extends MockCubit<ReportsState>
    implements ReportsCubit {}

void main() {
  late _MockReportsCubit cubit;

  AccountNode leaf(String account, int satang) => AccountNode(
    account: account,
    name: account.split(':').last,
    amount: thb(satang),
    ownAmount: thb(satang),
    ownEntryCount: 1,
    children: const [],
  );

  IncomeStatement statement({
    bool latest = true,
    bool earliest = false,
    bool empty = false,
  }) {
    final food = AccountNode(
      account: 'Expenses:Food',
      name: 'Food',
      amount: thb(20000),
      ownAmount: thb(0),
      ownEntryCount: 0,
      children: [leaf('Expenses:Food:Lunch', 20000)],
    );
    return IncomeStatement(
      month: DateTime(2026, 9),
      earliestMonth: earliest ? DateTime(2026, 9) : DateTime(2026, 1),
      latestMonth: latest ? DateTime(2026, 9) : DateTime(2026, 10),
      income: thb(empty ? 0 : 5000000),
      expenses: thb(empty ? 0 : 820000),
      net: thb(empty ? 0 : 4180000),
      savingsPerMille: empty ? null : 836,
      expensesPerMille: empty ? null : 164,
      expenseTree: AccountNode(
        account: 'Expenses',
        name: 'Expenses',
        amount: thb(empty ? 0 : 820000),
        ownAmount: thb(0),
        ownEntryCount: 0,
        children: empty ? [] : [leaf('Expenses:Rent', 800000), food],
      ),
      incomeTree: AccountNode(
        account: 'Income',
        name: 'Income',
        amount: thb(empty ? 0 : 5000000),
        ownAmount: thb(0),
        ownEntryCount: 0,
        children: empty ? [] : [leaf('Income:Salary', 5000000)],
      ),
    );
  }

  setUp(() {
    cubit = _MockReportsCubit();
    when(() => cubit.load()).thenAnswer((_) async {});
    when(() => cubit.previousMonth()).thenAnswer((_) async {});
    when(() => cubit.nextMonth()).thenAnswer((_) async {});
  });

  Future<void> pumpView(WidgetTester tester, ReportsState state) async {
    when(() => cubit.state).thenReturn(state);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<ReportsCubit>.value(value: cubit),
            BlocProvider(
              create: (_) => SettingsCubit(
                repository: FakeSettingsRepository(),
                initial: const AppSettings(yearEra: YearEra.gregorian),
              ),
            ),
          ],
          child: const ReportsView(),
        ),
      ),
    );
  }

  testWidgets('shows a spinner while loading', (tester) async {
    await pumpView(tester, const ReportsState(status: ReportsStatus.loading));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders the net overview', (tester) async {
    await pumpView(
      tester,
      ReportsState(status: ReportsStatus.success, statement: statement()),
    );

    expect(find.text('September 2026'), findsOneWidget);
    expect(find.text('+฿41,800.00'), findsOneWidget);
    expect(find.text('83.6%'), findsWidgets);
    expect(find.text('Saved'), findsOneWidget);
    expect(find.text('Expenses'), findsOneWidget);
    expect(find.text('Left over'), findsOneWidget);
    expect(find.text('Income'), findsOneWidget);
    expect(find.text('50,000.00'), findsOneWidget);
    expect(find.text('2 subcategories'), findsOneWidget);
  });

  testWidgets('the income row opens the income side', (tester) async {
    await pumpView(
      tester,
      ReportsState(status: ReportsStatus.success, statement: statement()),
    );

    await tester.ensureVisible(find.text('Income'));
    await tester.pump();
    await tester.tap(find.text('Income'));

    verify(() => cubit.openSide(ReportSide.income)).called(1);
  });

  testWidgets('lists the categories of the chosen side', (tester) async {
    final current = statement();
    await pumpView(
      tester,
      ReportsState(
        status: ReportsStatus.success,
        statement: current,
        side: ReportSide.expense,
      ),
    );

    expect(find.text('Expenses · 16.4% of Income'), findsOneWidget);
    expect(find.text('Rent'), findsWidgets);
    expect(find.text('97.6%'), findsWidgets);
    expect(find.text('1 entry'), findsOneWidget);
    expect(find.text('1 subcategory'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    verify(() => cubit.back()).called(1);
  });

  testWidgets('a drilled level shows its parent and the share of it', (
    tester,
  ) async {
    await pumpView(
      tester,
      ReportsState(
        status: ReportsStatus.success,
        statement: statement(),
        side: ReportSide.expense,
        drill: const ['Expenses:Food'],
      ),
    );

    expect(find.text('Food · 2.4% of Expenses'), findsOneWidget);
    expect(find.text('Lunch'), findsWidgets);
    final parentRow = find.byType(ParentAllocationRow);
    expect(parentRow, findsOneWidget);

    await tester.tap(parentRow);
    await tester.tap(find.byType(DonutChart));
    verify(() => cubit.back()).called(2);
  });

  testWidgets('shows an empty message for a month without entries', (
    tester,
  ) async {
    await pumpView(
      tester,
      ReportsState(
        status: ReportsStatus.success,
        statement: statement(empty: true),
      ),
    );

    expect(find.text('No transactions this month'), findsOneWidget);
  });

  testWidgets('month arrows call the cubit', (tester) async {
    await pumpView(
      tester,
      ReportsState(
        status: ReportsStatus.success,
        statement: statement(latest: false),
      ),
    );

    await tester.tap(find.byTooltip('Previous month'));
    await tester.tap(find.byTooltip('Next month'));

    verify(() => cubit.previousMonth()).called(1);
    verify(() => cubit.nextMonth()).called(1);
  });

  testWidgets('next month is disabled on the latest month', (tester) async {
    await pumpView(
      tester,
      ReportsState(status: ReportsStatus.success, statement: statement()),
    );

    await tester.tap(find.byTooltip('Next month'));

    verifyNever(() => cubit.nextMonth());
  });

  testWidgets('previous month is disabled on the earliest month', (
    tester,
  ) async {
    await pumpView(
      tester,
      ReportsState(
        status: ReportsStatus.success,
        statement: statement(earliest: true),
      ),
    );

    await tester.tap(find.byTooltip('Previous month'));

    verifyNever(() => cubit.previousMonth());
  });

  testWidgets('retry reloads after a failure', (tester) async {
    await pumpView(
      tester,
      const ReportsState(
        status: ReportsStatus.failure,
        error: ReportsError.loadFailed,
      ),
    );

    await tester.tap(find.text('Try again'));

    verify(() => cubit.load()).called(1);
  });
}
