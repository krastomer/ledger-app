import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/app.dart';
import 'package:ledger_app/domain/models/app_language.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/routing/router.dart';
import 'package:ledger_app/routing/routes.dart';
import 'package:ledger_app/ui/home/view/home_view.dart';
import 'package:ledger_app/ui/home/widgets/net_worth_card.dart';
import 'package:ledger_app/ui/home/widgets/review_banner.dart';
import 'package:ledger_app/ui/slip_review/view/slip_review_view.dart';
import 'package:ledger_app/utils/money_format.dart';
import 'package:ledger_app/ui/inbox/view/inbox_view.dart';
import 'package:ledger_app/ui/reports/view/reports_view.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';
import 'package:ledger_app/ui/settings/view/settings_view.dart';
import 'package:ledger_app/ui/setup/view/setup_import_view.dart';
import 'package:ledger_app/ui/setup/view/setup_new_view.dart';
import 'package:ledger_app/ui/setup/view/setup_photos_view.dart';
import 'package:ledger_app/ui/setup/view/setup_settings_view.dart';
import 'package:ledger_app/ui/setup/view/setup_welcome_view.dart';
import 'package:ledger_app/ui/transaction_detail/view/transaction_detail_view.dart';
import 'package:ledger_app/ui/transactions/view/transactions_view.dart';
import 'package:ledger_app/ui/accounts/view/accounts_view.dart';

import '../testing/fakes/fake_gallery_repository.dart';
import '../testing/fakes/fake_ledger_import_repository.dart';
import '../testing/fakes/fake_ledger_repository.dart';
import '../testing/fakes/fake_settings_repository.dart';
import '../testing/fakes/fake_slip_repository.dart';
import '../testing/fixtures/ledger_fixtures.dart';
import '../testing/fixtures/slip_draft_fixtures.dart';

void main() {
  late FakeLedgerRepository ledger;
  late FakeSettingsRepository settings;

  setUp(() {
    ledger = FakeLedgerRepository(
      accounts: fixtureAccounts,
      transactions: fixtureTransactions,
    );
    settings = FakeSettingsRepository();
  });

  Future<GoRouter> pumpAt(
    WidgetTester tester,
    String location, {
    AppSettings initial = const AppSettings(
      language: AppLanguage.en,
      yearEra: YearEra.gregorian,
      setupComplete: true,
    ),
  }) async {
    final router = createRouter(initialLocation: location);
    addTearDown(router.dispose);
    await tester.pumpWidget(
      App(
        galleryRepository: FakeGalleryRepository(),
        ledgerRepository: ledger,
        ledgerImportRepository: FakeLedgerImportRepository(),
        settingsRepository: settings,
        slipRepository: FakeSlipRepository({'slip.jpg': transferSlip()}),
        initialSettings: initial,
        router: router,
      ),
    );
    await tester.pumpAndSettle();
    return router;
  }

  testWidgets('opens Home with the four tabs', (tester) async {
    await pumpAt(tester, Routes.home);

    expect(find.byType(HomeView), findsOneWidget);
    expect(find.text('0:home*'), findsOneWidget);
    expect(find.text('1:journal'), findsOneWidget);
    expect(find.text('2:inbox[1]'), findsOneWidget);
    expect(find.text('3:config'), findsOneWidget);
  });

  testWidgets('the tabs switch screens and keep the inbox count', (
    tester,
  ) async {
    await pumpAt(tester, Routes.home);

    await tester.tap(find.text('1:journal'));
    await tester.pumpAndSettle();
    expect(find.byType(TransactionsView), findsOneWidget);

    await tester.tap(find.text('2:inbox[1]'));
    await tester.pumpAndSettle();
    expect(find.byType(InboxView), findsOneWidget);

    await tester.tap(find.text('3:config'));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsView), findsOneWidget);

    await tester.tap(find.text('0:home'));
    await tester.pumpAndSettle();
    expect(find.byType(HomeView), findsOneWidget);
  });

  testWidgets('the inbox count follows the ledger', (tester) async {
    await pumpAt(tester, Routes.home);

    await ledger.delete('rent');
    await tester.pumpAndSettle();

    expect(find.text('2:inbox'), findsOneWidget);
    expect(find.textContaining('[1]'), findsNothing);
  });

  testWidgets('Accounts and Reports open under Home', (tester) async {
    final router = await pumpAt(tester, Routes.accounts);
    expect(find.byType(AccountsView), findsOneWidget);

    router.go(Routes.reports);
    await tester.pumpAndSettle();
    expect(find.byType(ReportsView), findsOneWidget);
  });

  testWidgets('an entry opens on top of the tabs by its id', (tester) async {
    final router = await pumpAt(tester, Routes.home);

    unawaited(router.push(Routes.transactionPath('lunch')));
    await tester.pumpAndSettle();

    expect(find.byType(TransactionDetailView), findsOneWidget);
    expect(find.text('lunch'), findsWidgets);
    expect(find.text('0:home*'), findsNothing);
  });

  testWidgets('the setup screens are reachable', (tester) async {
    final router = await pumpAt(tester, Routes.setup);
    expect(find.byType(SetupSettingsView), findsOneWidget);

    router.go(Routes.setupStart);
    await tester.pumpAndSettle();
    expect(find.byType(SetupWelcomeView), findsOneWidget);

    router.go(Routes.setupNew);
    await tester.pumpAndSettle();
    expect(find.byType(SetupNewView), findsOneWidget);

    router.go(Routes.setupImport);
    await tester.pumpAndSettle();
    expect(find.byType(SetupImportView), findsOneWidget);

    router.go(Routes.setupPhotos);
    await tester.pumpAndSettle();
    expect(find.byType(SetupPhotosView), findsOneWidget);
  });

  testWidgets('follows the saved language and changes with it', (tester) async {
    await pumpAt(
      tester,
      Routes.home,
      initial: const AppSettings(setupComplete: true),
    );
    expect(find.text('1:รายการ'), findsOneWidget);

    final cubit = BlocProvider.of<SettingsCubit>(
      tester.element(find.byType(HomeView)),
    );
    await cubit.setLanguage(AppLanguage.en);
    await tester.pumpAndSettle();

    expect(find.text('1:journal'), findsOneWidget);
    expect(settings.saved.language, AppLanguage.en);
  });

  group('Home links', () {
    testWidgets('the net worth card opens Accounts', (tester) async {
      await pumpAt(tester, Routes.home);

      await tester.tap(find.byType(NetWorthCard));
      await tester.pumpAndSettle();

      expect(find.byType(AccountsView), findsOneWidget);
    });

    testWidgets('the review banner opens the Inbox', (tester) async {
      await pumpAt(tester, Routes.home);

      await tester.tap(find.byType(ReviewBanner));
      await tester.pumpAndSettle();

      expect(find.byType(InboxView), findsOneWidget);
    });

    testWidgets('the recent list opens the Journal', (tester) async {
      await pumpAt(tester, Routes.home);

      await tester.scrollUntilVisible(
        find.text('see all →'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('see all →'));
      await tester.pumpAndSettle();

      expect(find.byType(TransactionsView), findsOneWidget);
    });

    testWidgets('the month card opens Reports', (tester) async {
      await pumpAt(tester, Routes.home);

      await tester.scrollUntilVisible(
        find.textContaining('reports'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.textContaining('reports').first);
      await tester.pumpAndSettle();

      expect(find.byType(ReportsView), findsOneWidget);
    });

    testWidgets('masks amounts when "hide on launch" is turned on', (
      tester,
    ) async {
      await pumpAt(tester, Routes.home);
      expect(find.text(hiddenAmount), findsNothing);

      final cubit = BlocProvider.of<SettingsCubit>(
        tester.element(find.byType(HomeView)),
      );
      await cubit.setHideOnLaunch(true);
      await tester.pumpAndSettle();

      expect(find.text(hiddenAmount), findsWidgets);
    });
  });

  group('slip review route', () {
    testWidgets('reads the picked images, with a fallback for none', (
      tester,
    ) async {
      final router = await pumpAt(tester, Routes.home);

      unawaited(router.push(Routes.slipReview, extra: ['slip.jpg']));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(SlipReviewView), findsOneWidget);
    });

    testWidgets('closes at once when there is nothing to read', (tester) async {
      final router = await pumpAt(tester, Routes.home);

      unawaited(router.push(Routes.slipReview));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pumpAndSettle();

      expect(find.byType(SlipReviewView), findsNothing);
      expect(find.byType(HomeView), findsOneWidget);
    });
  });

  testWidgets('a journal entry opens its detail page', (tester) async {
    final now = DateTime.now();
    ledger.transactions.add(
      fixtureTransaction('team lunch', DateTime(now.year, now.month, now.day), {
        'Expenses:Food': thb(12000),
        'Assets:Bank:KBank': thb(-12000),
      }),
    );
    await pumpAt(tester, Routes.transactions);

    await tester.tap(find.text('team lunch'));
    await tester.pumpAndSettle();

    expect(find.byType(TransactionDetailView), findsOneWidget);
  });
}
