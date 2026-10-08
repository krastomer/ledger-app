@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/repositories/ledger/hledger_ledger_repository.dart';
import 'package:ledger_app/data/services/ledger_asset_service.dart';
import 'package:ledger_app/domain/models/app_language.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/models/starter_accounts.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/domain/use_cases/accounts_summary_use_case.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/domain/use_cases/home_summary_use_case.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/domain/use_cases/income_statement_use_case.dart';
import 'package:ledger_app/domain/use_cases/month_transactions_use_case.dart';
import 'package:ledger_app/domain/use_cases/review_queue_use_case.dart';
import 'package:ledger_app/domain/use_cases/transaction_detail_use_case.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/accounts/bloc/accounts_cubit.dart';
import 'package:ledger_app/ui/accounts/view/accounts_view.dart';
import 'package:ledger_app/ui/core/themes/app_theme.dart';
import 'package:ledger_app/ui/core/widgets/slip_image_viewer.dart';
import 'package:ledger_app/ui/home/bloc/home_cubit.dart';
import 'package:ledger_app/ui/home/view/home_view.dart';
import 'package:ledger_app/ui/inbox/bloc/inbox_cubit.dart';
import 'package:ledger_app/ui/inbox/view/inbox_view.dart';
import 'package:ledger_app/ui/reports/bloc/reports_cubit.dart';
import 'package:ledger_app/ui/reports/view/reports_view.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';
import 'package:ledger_app/ui/slip_review/bloc/slip_review_bloc.dart';
import 'package:ledger_app/ui/slip_review/view/slip_review_view.dart';
import 'package:ledger_app/ui/transaction_detail/bloc/transaction_detail_cubit.dart';
import 'package:ledger_app/ui/transaction_detail/view/transaction_detail_view.dart';
import 'package:ledger_app/ui/transactions/bloc/transactions_cubit.dart';
import 'package:ledger_app/ui/transactions/view/transactions_view.dart';
import 'package:ledger_app/utils/result.dart';

import '../../testing/fakes/fake_ledger_repository.dart';
import '../../testing/fakes/fake_settings_repository.dart';
import '../../testing/fakes/fake_slip_repository.dart';
import '../../testing/fixtures/slip_draft_fixtures.dart';

/// The states the main screen goldens don't show: errors, empty ledgers,
/// slips that can't be used, large text and a small phone. Regenerate with
/// `flutter test --update-goldens test/goldens/states_test.dart` and review
/// the PNG diffs.
void main() {
  const phone = Size(402, 874);
  const smallPhone = Size(360, 640);
  const pixelRatio = 2.0;
  const topInset = 62.0;
  final today = DateTime(2026, 9, 29, 21);
  late FakeLedgerRepository sample;
  late FakeLedgerRepository empty;
  late FakeLedgerRepository broken;
  DateTime now() => today;
  final ios = TargetPlatformVariant.only(TargetPlatform.iOS);

  setUpAll(() async {
    final bundled = HledgerLedgerRepository(
      source: LedgerAssetService(path: 'assets/ledger/sample.json'),
    );
    sample = FakeLedgerRepository(
      accounts: switch (await bundled.getAccounts()) {
        Ok(:final value) => value,
        Error(:final error) => throw error,
      },
      transactions: switch (await bundled.getTransactions()) {
        Ok(:final value) => value,
        Error(:final error) => throw error,
      },
    );
    empty = FakeLedgerRepository(accounts: starterAccounts);
    broken = FakeLedgerRepository(error: Exception('unreadable'));
  });

  Future<void> pumpScreen(
    WidgetTester tester,
    AppLanguage language, {
    required Widget child,
    BlocProvider? screenCubit,
    Size screen = phone,
    double textScale = 1,
  }) async {
    tester.view
      ..physicalSize = screen * pixelRatio
      ..devicePixelRatio = pixelRatio
      ..padding = const FakeViewPadding(top: topInset * pixelRatio)
      ..viewPadding = const FakeViewPadding(top: topInset * pixelRatio);
    addTearDown(tester.view.reset);
    final settings = AppSettings(
      language: language,
      yearEra: language == AppLanguage.th
          ? YearEra.buddhist
          : YearEra.gregorian,
    );
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark.copyWith(platform: TargetPlatform.iOS),
        locale: Locale(language.name),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, app) => MediaQuery.withClampedTextScaling(
          minScaleFactor: textScale,
          maxScaleFactor: textScale,
          child: app ?? const SizedBox.shrink(),
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => SettingsCubit(
                repository: FakeSettingsRepository(saved: settings),
                initial: settings,
              ),
            ),
            ?screenCubit,
          ],
          child: child,
        ),
      ),
    );
    await tester.pump();
  }

  Future<void> expectState(String name, AppLanguage language) => expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('states/${name}_${language.name}.png'),
  );

  HomeCubit homeCubit(FakeLedgerRepository ledger) => HomeCubit(
    homeSummary: HomeSummaryUseCase(ledgerRepository: ledger, now: now),
  );

  TransactionsCubit journalCubit(FakeLedgerRepository ledger) =>
      TransactionsCubit(
        monthTransactions: MonthTransactionsUseCase(
          ledgerRepository: ledger,
          now: now,
        ),
      );

  InboxCubit inboxCubit(FakeLedgerRepository ledger) => InboxCubit(
    reviewQueue: ReviewQueueUseCase(ledgerRepository: ledger),
    editTransaction: EditTransactionUseCase(ledgerRepository: ledger),
    importSlip: ImportSlipUseCase(
      slipRepository: FakeSlipRepository(const {}),
      ledgerRepository: ledger,
    ),
  );

  for (final language in AppLanguage.values) {
    group(language.name, () {
      testWidgets('home_failure', (tester) async {
        final cubit = homeCubit(broken);
        addTearDown(cubit.close);
        await cubit.load();
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<HomeCubit>.value(value: cubit),
          child: const HomeView(),
        );
        await expectState('home_failure', language);
      }, variant: ios);

      testWidgets('home_empty', (tester) async {
        final cubit = homeCubit(empty);
        addTearDown(cubit.close);
        await cubit.load();
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<HomeCubit>.value(value: cubit),
          child: const HomeView(),
        );
        await expectState('home_empty', language);
      }, variant: ios);

      testWidgets('journal_empty', (tester) async {
        final cubit = journalCubit(empty);
        addTearDown(cubit.close);
        await cubit.load();
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<TransactionsCubit>.value(value: cubit),
          child: const TransactionsView(),
        );
        await expectState('journal_empty', language);
      }, variant: ios);

      testWidgets('journal_no_match', (tester) async {
        final cubit = journalCubit(sample);
        addTearDown(cubit.close);
        await cubit.load();
        await cubit.setQuery('zzzz');
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<TransactionsCubit>.value(value: cubit),
          child: const TransactionsView(),
        );
        await expectState('journal_no_match', language);
      }, variant: ios);

      testWidgets('inbox_empty', (tester) async {
        final cubit = inboxCubit(empty);
        addTearDown(cubit.close);
        await cubit.load();
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<InboxCubit>.value(value: cubit),
          child: const InboxView(),
        );
        await expectState('inbox_empty', language);
      }, variant: ios);

      testWidgets('inbox_failure', (tester) async {
        final cubit = inboxCubit(broken);
        addTearDown(cubit.close);
        await cubit.load();
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<InboxCubit>.value(value: cubit),
          child: const InboxView(),
        );
        await expectState('inbox_failure', language);
      }, variant: ios);

      testWidgets('accounts_month_change', (tester) async {
        final cubit = AccountsCubit(
          accountsSummary: AccountsSummaryUseCase(
            ledgerRepository: sample,
            now: now,
          ),
        );
        addTearDown(cubit.close);
        await cubit.load();
        cubit.setMode(AccountsMode.monthChange);
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<AccountsCubit>.value(value: cubit),
          child: const AccountsView(),
        );
        await expectState('accounts_month_change', language);
      }, variant: ios);

      testWidgets('reports_income', (tester) async {
        final cubit = ReportsCubit(
          incomeStatement: IncomeStatementUseCase(
            ledgerRepository: sample,
            now: now,
          ),
        );
        addTearDown(cubit.close);
        await cubit.load();
        cubit.openSide(ReportSide.income);
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<ReportsCubit>.value(value: cubit),
          child: const ReportsView(),
        );
        await expectState('reports_income', language);
      }, variant: ios);

      testWidgets('transaction_not_found', (tester) async {
        final cubit = TransactionDetailCubit(
          id: 'gone',
          transactionDetail: TransactionDetailUseCase(ledgerRepository: sample),
          editTransaction: EditTransactionUseCase(ledgerRepository: sample),
        );
        addTearDown(cubit.close);
        await cubit.load();
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<TransactionDetailCubit>.value(value: cubit),
          child: const TransactionDetailView(),
        );
        await expectState('transaction_not_found', language);
      }, variant: ios);

      for (final state in ['unreadable', 'no_amount']) {
        testWidgets('slip_review_$state', (tester) async {
          // A Bloc only closes on the real clock, so it lives there.
          final bloc = await tester.runAsync(() async {
            final bloc = SlipReviewBloc(
              imagePaths: const ['slip-1.jpg', 'slip-2.jpg'],
              importSlip: ImportSlipUseCase(
                slipRepository: FakeSlipRepository({
                  if (state == 'no_amount')
                    'slip-1.jpg': transferSlip(satang: null),
                }),
                ledgerRepository: sample,
                now: now,
              ),
            )..add(const SlipReviewStarted());
            await bloc.stream.firstWhere(
              (s) =>
                  s.status == SlipReviewStatus.ready ||
                  s.status == SlipReviewStatus.unreadable,
            );
            return bloc;
          });
          if (bloc == null) fail('slip review did not start');
          await pumpScreen(
            tester,
            language,
            screenCubit: BlocProvider<SlipReviewBloc>.value(value: bloc),
            child: const SlipReviewView(),
          );
          await tester.runAsync(
            () => Future<void>.delayed(const Duration(milliseconds: 50)),
          );
          await tester.pump();
          await expectState('slip_review_$state', language);
          await tester.runAsync(bloc.close);
        }, variant: ios);
      }

      testWidgets('slip_image_missing', (tester) async {
        await pumpScreen(
          tester,
          language,
          child: const SlipImageViewer(imagePath: '/missing/for-golden.jpg'),
        );
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 300)),
        );
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        await expectState('slip_image_missing', language);
      }, variant: ios);
    });
  }

  group('large text and a small phone (th)', () {
    const language = AppLanguage.th;

    testWidgets('home_large_text', (tester) async {
      final cubit = homeCubit(sample);
      addTearDown(cubit.close);
      await cubit.load();
      await pumpScreen(
        tester,
        language,
        textScale: 1.6,
        screenCubit: BlocProvider<HomeCubit>.value(value: cubit),
        child: const HomeView(),
      );
      await expectState('home_large_text', language);
    }, variant: ios);

    testWidgets('journal_large_text', (tester) async {
      final cubit = journalCubit(sample);
      addTearDown(cubit.close);
      await cubit.load();
      await pumpScreen(
        tester,
        language,
        textScale: 1.6,
        screenCubit: BlocProvider<TransactionsCubit>.value(value: cubit),
        child: const TransactionsView(),
      );
      await expectState('journal_large_text', language);
    }, variant: ios);

    testWidgets('inbox_large_text', (tester) async {
      final cubit = inboxCubit(sample);
      addTearDown(cubit.close);
      await cubit.load();
      await pumpScreen(
        tester,
        language,
        textScale: 1.6,
        screenCubit: BlocProvider<InboxCubit>.value(value: cubit),
        child: const InboxView(),
      );
      await expectState('inbox_large_text', language);
    }, variant: ios);

    testWidgets('home_small_phone', (tester) async {
      final cubit = homeCubit(sample);
      addTearDown(cubit.close);
      await cubit.load();
      await pumpScreen(
        tester,
        language,
        screen: smallPhone,
        screenCubit: BlocProvider<HomeCubit>.value(value: cubit),
        child: const HomeView(),
      );
      await expectState('home_small_phone', language);
    }, variant: ios);

    testWidgets('journal_small_phone', (tester) async {
      final cubit = journalCubit(sample);
      addTearDown(cubit.close);
      await cubit.load();
      await pumpScreen(
        tester,
        language,
        screen: smallPhone,
        screenCubit: BlocProvider<TransactionsCubit>.value(value: cubit),
        child: const TransactionsView(),
      );
      await expectState('journal_small_phone', language);
    }, variant: ios);

    testWidgets('reports_small_phone', (tester) async {
      final cubit = ReportsCubit(
        incomeStatement: IncomeStatementUseCase(
          ledgerRepository: sample,
          now: now,
        ),
      );
      addTearDown(cubit.close);
      await cubit.load();
      await pumpScreen(
        tester,
        language,
        screen: smallPhone,
        screenCubit: BlocProvider<ReportsCubit>.value(value: cubit),
        child: const ReportsView(),
      );
      await expectState('reports_small_phone', language);
    }, variant: ios);
  });
}
