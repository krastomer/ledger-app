import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/models/month_transactions.dart';
import 'package:ledger_app/domain/models/transaction_day.dart';
import 'package:ledger_app/domain/models/transaction_filter.dart';
import 'package:ledger_app/domain/models/transaction_kind.dart';
import 'package:ledger_app/domain/models/transaction_summary.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/core/themes/app_theme.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';
import 'package:ledger_app/ui/transactions/bloc/transactions_cubit.dart';
import 'package:ledger_app/ui/transactions/view/transactions_view.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/fakes/fake_settings_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

class _MockTransactionsCubit extends MockCubit<TransactionsState>
    implements TransactionsCubit {}

void main() {
  late _MockTransactionsCubit cubit;

  TransactionSummary summary(
    String id,
    TransactionKind kind, {
    Duration? time,
    bool isPending = false,
    bool hasSlip = false,
  }) => TransactionSummary(
    id: id,
    description: id,
    date: fixtureToday,
    time: time,
    from: 'KBank',
    to: 'Food',
    amount: thb(6000),
    kind: kind,
    isPending: isPending,
    hasSlip: hasSlip,
  );

  MonthTransactions data({
    bool earliest = false,
    bool latest = true,
    bool empty = false,
  }) => MonthTransactions(
    month: DateTime(2026, 9),
    earliestMonth: earliest ? DateTime(2026, 9) : DateTime(2026, 1),
    latestMonth: latest ? DateTime(2026, 9) : DateTime(2026, 10),
    income: thb(5000000),
    expenses: thb(825000),
    net: thb(4175000),
    days: empty
        ? []
        : [
            TransactionDay(
              date: fixtureToday,
              isToday: true,
              transactions: [
                summary(
                  'lunch',
                  TransactionKind.expense,
                  time: const Duration(hours: 12, minutes: 41),
                  hasSlip: true,
                ),
                summary('rent', TransactionKind.expense, isPending: true),
                summary('to savings', TransactionKind.transfer),
              ],
            ),
            TransactionDay(
              date: DateTime(2026, 9, 25),
              isToday: false,
              transactions: [summary('salary', TransactionKind.income)],
            ),
          ],
  );

  setUp(() {
    cubit = _MockTransactionsCubit();
    when(() => cubit.load()).thenAnswer((_) async {});
    when(() => cubit.previousMonth()).thenAnswer((_) async {});
    when(() => cubit.nextMonth()).thenAnswer((_) async {});
    when(() => cubit.setQuery(any())).thenAnswer((_) async {});
    when(() => cubit.togglePendingOnly()).thenAnswer((_) async {});
    when(() => cubit.toggleWithSlipOnly()).thenAnswer((_) async {});
  });

  Future<void> pumpView(WidgetTester tester, TransactionsState state) async {
    when(() => cubit.state).thenReturn(state);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<TransactionsCubit>.value(value: cubit),
            BlocProvider(
              create: (_) => SettingsCubit(
                repository: FakeSettingsRepository(),
                initial: const AppSettings(yearEra: YearEra.gregorian),
              ),
            ),
          ],
          child: const TransactionsView(),
        ),
      ),
    );
  }

  TransactionsState success(MonthTransactions data) =>
      TransactionsState(status: TransactionsStatus.success, data: data);

  testWidgets('shows a spinner while loading', (tester) async {
    await pumpView(
      tester,
      const TransactionsState(status: TransactionsStatus.loading),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders totals and transactions grouped by day', (tester) async {
    await pumpView(tester, success(data()));

    expect(find.text('Sep 2026'), findsOneWidget);
    expect(find.text('+50,000.00'), findsOneWidget);
    expect(find.text('4 shown'), findsOneWidget);
    expect(find.text('Tue, Sep 29 · Today'), findsOneWidget);
    expect(find.text('Fri, Sep 25'), findsOneWidget);
    expect(find.text('lunch'), findsOneWidget);
    expect(find.text('KBank → Food'), findsWidgets);
    expect(find.text('12:41'), findsOneWidget);
    expect(find.text('--:--'), findsNWidgets(3));
    expect(find.text('!'), findsOneWidget);
    expect(find.text('[slip]'), findsOneWidget);
    expect(find.text('−60.00'), findsNWidgets(2));
    expect(find.text('60.00'), findsOneWidget);
    expect(find.text('+60.00'), findsOneWidget);
  });

  testWidgets('shows an empty message for a month without entries', (
    tester,
  ) async {
    await pumpView(tester, success(data(empty: true)));

    expect(find.text('No transactions this month'), findsOneWidget);
  });

  testWidgets('shows a different empty message while filtering', (
    tester,
  ) async {
    await pumpView(
      tester,
      TransactionsState(
        status: TransactionsStatus.success,
        data: data(empty: true),
        filter: const TransactionFilter(query: 'zzz'),
      ),
    );

    expect(find.text('No matching transactions'), findsOneWidget);
  });

  testWidgets('month arrows call the cubit', (tester) async {
    await pumpView(tester, success(data(latest: false)));

    await tester.tap(find.byTooltip('Previous month'));
    await tester.tap(find.byTooltip('Next month'));

    verify(() => cubit.previousMonth()).called(1);
    verify(() => cubit.nextMonth()).called(1);
  });

  testWidgets('arrows are disabled at the ends of the ledger', (tester) async {
    await pumpView(tester, success(data(earliest: true)));

    await tester.tap(find.byTooltip('Previous month'));
    await tester.tap(find.byTooltip('Next month'));

    verifyNever(() => cubit.previousMonth());
    verifyNever(() => cubit.nextMonth());
  });

  testWidgets('typing searches and the filter chips toggle', (tester) async {
    await pumpView(tester, success(data()));

    await tester.enterText(find.byType(TextField), 'lunch');
    await tester.pump();
    await tester.tap(find.text('--pending'));
    await tester.tap(find.text('--slip'));
    await tester.tap(find.byTooltip('Clear search'));

    verify(() => cubit.setQuery('lunch')).called(1);
    verify(() => cubit.setQuery('')).called(1);
    verify(() => cubit.togglePendingOnly()).called(1);
    verify(() => cubit.toggleWithSlipOnly()).called(1);
  });

  testWidgets('retry reloads after a failure', (tester) async {
    await pumpView(
      tester,
      const TransactionsState(
        status: TransactionsStatus.failure,
        error: TransactionsError.loadFailed,
      ),
    );

    await tester.tap(find.text('< try again >'));

    verify(() => cubit.load()).called(1);
  });
}
