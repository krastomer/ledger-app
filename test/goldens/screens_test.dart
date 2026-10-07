@Tags(['golden'])
library;

import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/repositories/ledger/hledger_ledger_repository.dart';
import 'package:ledger_app/data/services/ledger_asset_service.dart';
import 'package:ledger_app/domain/models/app_language.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/domain/use_cases/accounts_summary_use_case.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/domain/use_cases/home_summary_use_case.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/domain/use_cases/income_statement_use_case.dart';
import 'package:ledger_app/domain/use_cases/ledger_check_use_case.dart';
import 'package:ledger_app/domain/use_cases/month_transactions_use_case.dart';
import 'package:ledger_app/domain/use_cases/review_queue_use_case.dart';
import 'package:ledger_app/domain/use_cases/transaction_detail_use_case.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/accounts/bloc/accounts_cubit.dart';
import 'package:ledger_app/ui/accounts/view/accounts_view.dart';
import 'package:ledger_app/ui/boot/bloc/boot_cubit.dart';
import 'package:ledger_app/ui/boot/view/boot_view.dart';
import 'package:ledger_app/ui/core/themes/app_theme.dart';
import 'package:ledger_app/ui/core/widgets/choice_page.dart';
import 'package:ledger_app/ui/core/widgets/slip_thumbnail.dart';
import 'package:ledger_app/ui/home/bloc/home_cubit.dart';
import 'package:ledger_app/ui/home/view/home_view.dart';
import 'package:ledger_app/ui/inbox/bloc/inbox_cubit.dart';
import 'package:ledger_app/ui/inbox/view/inbox_view.dart';
import 'package:ledger_app/ui/reports/bloc/reports_cubit.dart';
import 'package:ledger_app/ui/reports/view/reports_view.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';
import 'package:ledger_app/ui/settings/view/settings_view.dart';
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

/// Every main screen on the bundled sample ledger, as an iPhone 17 shows it
/// on 2026-09-29. Regenerate with
/// `flutter test --update-goldens test/goldens` and review the PNG diffs.
void main() {
  const screen = Size(402, 874);
  const pixelRatio = 2.0;
  const topInset = 62.0;
  final today = DateTime(2026, 9, 29, 21);
  late FakeLedgerRepository ledger;
  late String rentId;
  late String slipImage;
  DateTime now() => today;
  final ios = TargetPlatformVariant.only(TargetPlatform.iOS);

  setUpAll(() async {
    // Parsed outside the tests' fake clock, where real futures never finish.
    final sample = HledgerLedgerRepository(
      source: LedgerAssetService(path: 'assets/ledger/sample.json'),
    );
    ledger = FakeLedgerRepository(
      accounts: switch (await sample.getAccounts()) {
        Ok(:final value) => value,
        Error(:final error) => throw error,
      },
      transactions: switch (await sample.getTransactions()) {
        Ok(:final value) => value,
        Error(:final error) => throw error,
      },
    );
    rentId = ledger.transactions
        .firstWhere((t) => t.status == TransactionStatus.pending)
        .id;
    slipImage = await _fakeSlipImage();
  });

  Future<void> pumpScreen(
    WidgetTester tester,
    AppLanguage language, {
    required Widget child,
    BlocProvider? screenCubit,
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

  Future<void> expectScreen(String name, AppLanguage language) => expectLater(
    find.byType(MaterialApp),
    matchesGoldenFile('screens/${name}_${language.name}.png'),
  );

  for (final language in AppLanguage.values) {
    group(language.name, () {
      testWidgets('home', (tester) async {
        final cubit = HomeCubit(
          homeSummary: HomeSummaryUseCase(ledgerRepository: ledger, now: now),
        );
        addTearDown(cubit.close);
        await cubit.load();
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<HomeCubit>.value(value: cubit),
          child: const HomeView(),
        );
        await expectScreen('home', language);
      }, variant: ios);

      testWidgets('journal', (tester) async {
        final cubit = TransactionsCubit(
          monthTransactions: MonthTransactionsUseCase(
            ledgerRepository: ledger,
            now: now,
          ),
        );
        addTearDown(cubit.close);
        await cubit.load();
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<TransactionsCubit>.value(value: cubit),
          child: const TransactionsView(),
        );
        await expectScreen('journal', language);
      }, variant: ios);

      for (final side in [null, ReportSide.expense]) {
        final name = 'reports_${side?.name ?? 'net'}';
        testWidgets(name, (tester) async {
          final cubit = ReportsCubit(
            incomeStatement: IncomeStatementUseCase(
              ledgerRepository: ledger,
              now: now,
            ),
          );
          addTearDown(cubit.close);
          await cubit.load();
          if (side != null) cubit.openSide(side);
          await pumpScreen(
            tester,
            language,
            screenCubit: BlocProvider<ReportsCubit>.value(value: cubit),
            child: const ReportsView(),
          );
          await expectScreen(name, language);
        }, variant: ios);
      }

      testWidgets('accounts', (tester) async {
        final cubit = AccountsCubit(
          accountsSummary: AccountsSummaryUseCase(
            ledgerRepository: ledger,
            now: now,
          ),
        );
        addTearDown(cubit.close);
        await cubit.load();
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<AccountsCubit>.value(value: cubit),
          child: const AccountsView(),
        );
        await expectScreen('accounts', language);
      }, variant: ios);

      testWidgets('config', (tester) async {
        await pumpScreen(tester, language, child: const SettingsView());
        await expectScreen('config', language);
      }, variant: ios);

      testWidgets('pick_language', (tester) async {
        await pumpScreen(
          tester,
          language,
          child: ChoicePage<AppLanguage>(
            title: language == AppLanguage.th ? 'ภาษา' : 'language',
            selected: language,
            options: const [
              (AppLanguage.en, 'English'),
              (AppLanguage.th, 'ไทย'),
            ],
          ),
        );
        await expectScreen('pick_language', language);
      }, variant: ios);

      testWidgets('pick_category', (tester) async {
        await pumpScreen(
          tester,
          language,
          child: const ChoicePage<String>(
            title: 'category',
            selected: 'expenses:rent',
            searchable: true,
            options: [
              ('expenses:food', 'expenses:food'),
              ('expenses:transport', 'expenses:transport'),
              ('expenses:rent', 'expenses:rent'),
              ('expenses:utilities', 'expenses:utilities'),
              ('expenses:uncategorized', 'expenses:uncategorized'),
              ('income:salary', 'income:salary'),
              ('income:interest', 'income:interest'),
            ],
          ),
        );
        await expectScreen('pick_category', language);
      }, variant: ios);

      testWidgets('boot', (tester) async {
        final cubit = BootCubit(
          ledgerCheck: LedgerCheckUseCase(ledgerRepository: ledger),
        );
        addTearDown(cubit.close);
        await cubit.run();
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<BootCubit>.value(value: cubit),
          child: const BootView(),
        );
        await expectScreen('boot', language);
      }, variant: ios);

      testWidgets('inbox', (tester) async {
        final cubit = InboxCubit(
          reviewQueue: ReviewQueueUseCase(ledgerRepository: ledger),
          editTransaction: EditTransactionUseCase(ledgerRepository: ledger),
          importSlip: ImportSlipUseCase(
            slipRepository: FakeSlipRepository(const {}),
            ledgerRepository: ledger,
          ),
        );
        addTearDown(cubit.close);
        await cubit.load();
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<InboxCubit>.value(value: cubit),
          child: const InboxView(),
        );
        await expectScreen('inbox', language);
      }, variant: ios);

      testWidgets('transaction', (tester) async {
        final cubit = TransactionDetailCubit(
          id: rentId,
          transactionDetail: TransactionDetailUseCase(ledgerRepository: ledger),
          editTransaction: EditTransactionUseCase(ledgerRepository: ledger),
        );
        addTearDown(cubit.close);
        await cubit.load();
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<TransactionDetailCubit>.value(value: cubit),
          child: const TransactionDetailView(),
        );
        await expectScreen('transaction', language);
      }, variant: ios);

      testWidgets('transaction_slip', (tester) async {
        final slipLedger = FakeLedgerRepository(
          accounts: ledger.accounts,
          transactions: [
            for (final t in ledger.transactions)
              t.id == rentId ? t.copyWith(slipImagePath: slipImage) : t,
          ],
        );
        final cubit = TransactionDetailCubit(
          id: rentId,
          transactionDetail: TransactionDetailUseCase(
            ledgerRepository: slipLedger,
          ),
          editTransaction: EditTransactionUseCase(ledgerRepository: slipLedger),
        );
        addTearDown(cubit.close);
        await cubit.load();
        // Decoded on the real clock first, so the screen finds it cached.
        await tester.runAsync(() async {
          final decoded = Completer<void>();
          FileImage(File(slipImage))
              .resolve(ImageConfiguration.empty)
              .addListener(
                ImageStreamListener(
                  (_, _) => decoded.complete(),
                  onError: decoded.completeError,
                ),
              );
          await decoded.future;
        });
        await pumpScreen(
          tester,
          language,
          screenCubit: BlocProvider<TransactionDetailCubit>.value(value: cubit),
          child: const TransactionDetailView(),
        );
        await tester.scrollUntilVisible(
          find.byType(SlipThumbnail),
          200,
          scrollable: find.byType(Scrollable).first,
        );
        await tester.pump();
        await expectScreen('transaction_slip', language);

        await tester.tap(find.byType(SlipThumbnail));
        await tester.pumpAndSettle();
        await expectScreen('slip_image', language);
      }, variant: ios);

      testWidgets('slip_review', (tester) async {
        // A Bloc only closes on the real clock, so it lives there.
        final bloc = await tester.runAsync(() async {
          final bloc = SlipReviewBloc(
            imagePaths: const ['slip-1.jpg', 'slip-2.jpg', 'slip-3.jpg'],
            importSlip: ImportSlipUseCase(
              slipRepository: FakeSlipRepository({
                'slip-1.jpg': transferSlip(
                  payee: 'โอนค่าห้อง',
                  reference: 'SAMPLE-REF-0005',
                  confidence: const {SlipField.to: 0.3},
                ),
              }),
              ledgerRepository: ledger,
              now: now,
            ),
          )..add(const SlipReviewStarted());
          await bloc.stream.firstWhere(
            (state) => state.status == SlipReviewStatus.ready,
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
        // Let the (missing) slip image fail to load with real I/O.
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 50)),
        );
        await tester.pump();
        await expectScreen('slip_review', language);
        await tester.runAsync(bloc.close);
      }, variant: ios);
    });
  }
}

/// A made-up bank slip: a header band and grey bars for text.
Future<String> _fakeSlipImage() async {
  const size = Size(600, 960);
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final paint = Paint();
  canvas
    ..drawRect(Offset.zero & size, paint..color = const Color(0xFFF4F6F2))
    ..drawRect(
      const Rect.fromLTWH(0, 0, 600, 140),
      paint..color = const Color(0xFF138F2D),
    );
  paint.color = const Color(0xFFB9BEB6);
  for (var row = 0; row < 9; row++) {
    canvas.drawRect(
      Rect.fromLTWH(48, 200 + row * 72.0, row.isEven ? 360 : 260, 28),
      paint,
    );
  }
  final image = await recorder.endRecording().toImage(600, 960);
  final png = await image.toByteData(format: ui.ImageByteFormat.png);
  if (png == null) throw StateError('could not encode the slip image');
  final file = File(
    '${Directory.systemTemp.createTempSync('slip').path}/slip.png',
  )..writeAsBytesSync(png.buffer.asUint8List());
  return file.path;
}
