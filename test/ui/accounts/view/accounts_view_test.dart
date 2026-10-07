import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/account_node.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/accounts_summary.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/accounts/bloc/accounts_cubit.dart';
import 'package:ledger_app/ui/accounts/view/accounts_view.dart';
import 'package:ledger_app/ui/core/themes/app_theme.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/fakes/fake_settings_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

class _MockAccountsCubit extends MockCubit<AccountsState>
    implements AccountsCubit {}

void main() {
  late _MockAccountsCubit cubit;

  AccountNode node(String account, int satang, [List<AccountNode>? children]) =>
      AccountNode(
        account: account,
        name: account.split(':').last,
        amount: thb(satang),
        ownAmount: children == null ? thb(satang) : thb(0),
        ownEntryCount: children == null ? 1 : 0,
        children: children ?? const [],
      );

  final summary = AccountsSummary(
    asOf: fixtureToday,
    netWorth: thb(14025000),
    assets: thb(14130000),
    liabilities: thb(105000),
    sections: [
      AccountSection(
        type: AccountType.asset,
        balance: [
          node('Assets', 14130000, [
            node('Assets:Bank', 14130000, [
              node('Assets:Bank:KBank', 13380000),
              node('Assets:Bank:Savings', 750000),
            ]),
          ]),
        ],
        monthChange: const [],
      ),
      AccountSection(
        type: AccountType.expense,
        balance: [
          node('Expenses', 825000, [node('Expenses:Rent', 800000)]),
        ],
        monthChange: [
          node('Expenses', 825000, [node('Expenses:Rent', 800000)]),
        ],
      ),
    ],
  );

  setUp(() {
    cubit = _MockAccountsCubit();
    when(() => cubit.load()).thenAnswer((_) async {});
  });

  Future<void> pumpView(WidgetTester tester, AccountsState state) async {
    when(() => cubit.state).thenReturn(state);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AccountsCubit>.value(value: cubit),
            BlocProvider(
              create: (_) => SettingsCubit(
                repository: FakeSettingsRepository(),
                initial: const AppSettings(yearEra: YearEra.gregorian),
              ),
            ),
          ],
          child: const AccountsView(),
        ),
      ),
    );
  }

  AccountsState success({
    AccountsMode mode = AccountsMode.balance,
    Set<String> expanded = const {'Assets', 'Assets:Bank'},
  }) => AccountsState(
    status: AccountsStatus.success,
    summary: summary,
    mode: mode,
    expanded: expanded,
  );

  testWidgets('shows a spinner while loading', (tester) async {
    await pumpView(tester, const AccountsState(status: AccountsStatus.loading));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders net worth and the open accounts', (tester) async {
    await pumpView(tester, success());

    expect(find.text('balance sheet'), findsOneWidget);
    expect(find.text('As of Sep 29, 2026'), findsOneWidget);
    expect(find.text('140,250.00'), findsOneWidget);
    expect(find.text('net worth'), findsOneWidget);
    expect(find.text('KBank'), findsOneWidget);
    expect(find.text('133,800.00'), findsOneWidget);
    expect(find.text('income statement'), findsOneWidget);
    expect(find.text('Sep 2026'), findsOneWidget);
    expect(find.text('Rent'), findsNothing);
  });

  testWidgets('the chevron toggles an account', (tester) async {
    await pumpView(tester, success());

    await tester.tap(find.byTooltip('Expand Expenses'));

    verify(() => cubit.toggle('Expenses')).called(1);
  });

  testWidgets('shows collapse for open accounts and drops closed children', (
    tester,
  ) async {
    await pumpView(tester, success(expanded: const {'Assets'}));

    expect(find.byTooltip('Collapse Assets'), findsOneWidget);
    expect(find.text('Bank'), findsOneWidget);
    expect(find.text('KBank'), findsNothing);
  });

  testWidgets('switching the view calls the cubit', (tester) async {
    await pumpView(tester, success());

    await tester.tap(find.text("this month's change"));

    verify(() => cubit.setMode(AccountsMode.monthChange)).called(1);
  });

  testWidgets('month change hides the assets that did not move', (
    tester,
  ) async {
    await pumpView(tester, success(mode: AccountsMode.monthChange));

    expect(find.text('KBank'), findsNothing);
    expect(find.text('Expenses'), findsOneWidget);
    expect(find.text('net worth'), findsNothing);
  });

  testWidgets('retry reloads after a failure', (tester) async {
    await pumpView(
      tester,
      const AccountsState(
        status: AccountsStatus.failure,
        error: AccountsError.loadFailed,
      ),
    );

    await tester.tap(find.text('< try again >'));

    verify(() => cubit.load()).called(1);
  });
}
