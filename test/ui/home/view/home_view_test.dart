import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/models/category_total.dart';
import 'package:ledger_app/domain/models/home_summary.dart';
import 'package:ledger_app/domain/models/transaction_kind.dart';
import 'package:ledger_app/domain/models/transaction_summary.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/core/themes/app_theme.dart';
import 'package:ledger_app/ui/home/bloc/home_cubit.dart';
import 'package:ledger_app/ui/home/view/home_view.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';
import 'package:ledger_app/utils/money_format.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/fakes/fake_settings_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

class _MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
  late _MockHomeCubit cubit;

  final summary = HomeSummary(
    asOf: fixtureToday,
    netWorth: thb(14025000),
    assets: thb(14130000),
    liabilities: thb(105000),
    monthIncome: thb(5000000),
    monthExpenses: thb(825000),
    monthNet: thb(4175000),
    topSpending: [
      CategoryTotal(
        account: 'Expenses:Rent',
        name: 'Rent',
        amount: thb(800000),
        sharePerMille: 969,
      ),
    ],
    recent: [
      TransactionSummary(
        id: 'bts',
        description: 'BTS',
        date: fixtureToday,
        from: 'Credit card',
        to: 'Transport',
        amount: thb(5000),
        kind: TransactionKind.expense,
        isPending: false,
        hasSlip: false,
      ),
    ],
    reviewCount: 2,
  );

  setUp(() {
    cubit = _MockHomeCubit();
    when(() => cubit.load()).thenAnswer((_) async {});
  });

  Future<void> pumpView(WidgetTester tester, HomeState state) async {
    when(() => cubit.state).thenReturn(state);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<HomeCubit>.value(value: cubit),
            BlocProvider(
              create: (_) => SettingsCubit(
                repository: FakeSettingsRepository(),
                initial: const AppSettings(yearEra: YearEra.gregorian),
              ),
            ),
          ],
          child: const HomeView(),
        ),
      ),
    );
  }

  testWidgets('shows a spinner while loading', (tester) async {
    await pumpView(tester, const HomeState(status: HomeStatus.loading));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders the summary', (tester) async {
    await pumpView(
      tester,
      HomeState(status: HomeStatus.success, summary: summary),
    );

    expect(find.text('net worth'), findsOneWidget);
    expect(find.text('140,250.00'), findsOneWidget);
    expect(find.text('−1,050.00'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('items need review'), findsOneWidget);
    expect(find.text('sep 2026'), findsOneWidget);
    expect(find.text('Rent'), findsOneWidget);
    expect(find.text('09-29'), findsOneWidget);
    expect(find.text('BTS'), findsOneWidget);
    expect(find.text('−50.00'), findsOneWidget);
  });

  testWidgets('masks amounts when hidden', (tester) async {
    await pumpView(
      tester,
      HomeState(
        status: HomeStatus.success,
        summary: summary,
        amountsHidden: true,
      ),
    );

    expect(find.text('140,250.00'), findsNothing);
    expect(find.text(hiddenAmount), findsWidgets);
  });

  testWidgets('shows retry on failure', (tester) async {
    await pumpView(
      tester,
      const HomeState(status: HomeStatus.failure, error: HomeError.loadFailed),
    );

    await tester.tap(find.text('< try again >'));

    verify(() => cubit.load()).called(1);
  });
}
