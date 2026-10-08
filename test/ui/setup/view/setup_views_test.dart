import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/data/parsers/hledger/parsed_ledger.dart';
import 'package:ledger_app/data/repositories/ledger/hledger_ledger_repository.dart';
import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/ledger_import_draft.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/ui/setup/bloc/setup_cubit.dart';
import 'package:ledger_app/ui/setup/view/setup_import_view.dart';
import 'package:ledger_app/ui/setup/view/setup_new_view.dart';
import 'package:ledger_app/ui/setup/view/setup_welcome_view.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../../testing/fakes/fake_ledger_import_repository.dart';
import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fakes/fake_settings_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';
import '../../../../testing/widget_harness.dart';

class _RejectingReplace extends FakeLedgerRepository {
  @override
  Future<Result<void>> replaceAll({
    required List<Account> accounts,
    required List<LedgerTransaction> transactions,
  }) async => Result.error(Exception('disk'));
}

class _SlowReplace extends FakeLedgerRepository {
  final gate = Completer<void>();

  @override
  Future<Result<void>> replaceAll({
    required List<Account> accounts,
    required List<LedgerTransaction> transactions,
  }) async {
    await gate.future;
    return super.replaceAll(accounts: accounts, transactions: transactions);
  }
}

void main() {
  late FakeLedgerRepository ledger;
  late FakeLedgerImportRepository imports;
  late FakeSettingsRepository settings;

  setUp(() {
    ledger = FakeLedgerRepository();
    imports = FakeLedgerImportRepository();
    settings = FakeSettingsRepository();
  });

  LedgerImportDraft draftOf(List<LedgerTransaction> transactions) =>
      LedgerImportDraft(
        fileName: 'ledger.json',
        sizeBytes: 3000,
        accounts: const [Account(name: 'Assets', type: AccountType.asset)],
        transactions: transactions,
      );

  Future<SetupCubit> pumpSetup(WidgetTester tester, Widget view) async {
    final cubit = SetupCubit(
      importRepository: imports,
      ledgerRepository: ledger,
    );
    addTearDown(cubit.close);
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) =>
              BlocProvider<SetupCubit>.value(value: cubit, child: view),
        ),
      ],
    );
    addTearDown(router.dispose);
    await pumpApp(tester, router: router, settingsRepository: settings);
    return cubit;
  }

  group('SetupWelcomeView', () {
    Future<GoRouter> pumpWelcome(WidgetTester tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(path: '/', builder: (_, _) => const SetupWelcomeView()),
          GoRoute(
            path: '/setup/new',
            builder: (_, _) => const Text('new ledger page'),
          ),
          GoRoute(
            path: '/setup/import',
            builder: (_, _) => const Text('import page'),
          ),
        ],
      );
      addTearDown(router.dispose);
      await pumpApp(tester, router: router);
      return router;
    }

    testWidgets('continues to a new ledger by default', (tester) async {
      await pumpWelcome(tester);

      await tester.tap(find.text('< continue >'));
      await tester.pumpAndSettle();

      expect(find.text('new ledger page'), findsOneWidget);
    });

    testWidgets('continues to the import after choosing it', (tester) async {
      await pumpWelcome(tester);

      await tester.tap(find.text('import hledger'));
      await tester.pump();
      await tester.tap(find.text('< continue >'));
      await tester.pumpAndSettle();

      expect(find.text('import page'), findsOneWidget);
    });

    testWidgets('can switch back to a new ledger', (tester) async {
      await pumpWelcome(tester);

      await tester.tap(find.text('import hledger'));
      await tester.pump();
      await tester.tap(find.text('start new ledger'));
      await tester.pump();
      await tester.tap(find.text('< continue >'));
      await tester.pumpAndSettle();

      expect(find.text('new ledger page'), findsOneWidget);
    });
  });

  group('SetupNewView', () {
    testWidgets('creating the ledger replaces the books with the starter set', (
      tester,
    ) async {
      await pumpSetup(tester, const SetupNewView());

      await tester.tap(find.text('< create ledger >'));
      await tester.pumpAndSettle();

      expect(ledger.accounts.map((a) => a.name), contains('Assets'));
      expect(ledger.transactions, isEmpty);
      expect(settings.saved.setupComplete, isTrue);
    });

    testWidgets('cannot be pressed twice while saving', (tester) async {
      final slow = _SlowReplace();
      ledger = slow;
      final cubit = await pumpSetup(tester, const SetupNewView());

      unawaited(cubit.startNew());
      await tester.pump();

      final button = tester.widget<TextButton>(
        find.ancestor(
          of: find.text('< create ledger >'),
          matching: find.byType(TextButton),
        ),
      );
      expect(button.onPressed, isNull);

      slow.gate.complete();
      await tester.pumpAndSettle();
    });
  });

  group('SetupImportView', () {
    testWidgets('asks for a file before anything was chosen', (tester) async {
      await pumpSetup(tester, const SetupImportView());

      expect(
        find.text('# Pick the file made by hledger print -O json'),
        findsOneWidget,
      );
      expect(find.text('< choose file >'), findsOneWidget);
      expect(find.text('< import 0 >'), findsOneWidget);
    });

    testWidgets('shows what the chosen file holds', (tester) async {
      imports.draft = draftOf(fixtureTransactions);
      final cubit = await pumpSetup(tester, const SetupImportView());

      await cubit.pickFile();
      await tester.pump();

      expect(find.text('ledger.json'), findsOneWidget);
      expect(find.text('3 KB'), findsOneWidget);
      expect(find.text('${fixtureTransactions.length}'), findsOneWidget);
      expect(find.textContaining('all balanced'), findsOneWidget);
      expect(find.text('< choose another file >'), findsOneWidget);
      expect(
        find.text('< import ${fixtureTransactions.length} >'),
        findsOneWidget,
      );
    });

    testWidgets('warns about entries that do not balance', (tester) async {
      imports.draft = draftOf([
        ...fixtureTransactions,
        fixtureTransaction('broken', DateTime(2026, 9), {
          'Expenses:Food': thb(100),
          'Assets:Bank:KBank': thb(-90),
        }),
      ]);
      final cubit = await pumpSetup(tester, const SetupImportView());

      await cubit.pickFile();
      await tester.pump();

      expect(find.text("! 1 don't balance"), findsOneWidget);
    });

    testWidgets('says when the file cannot be opened', (tester) async {
      imports.error = Exception('no access');
      final cubit = await pumpSetup(tester, const SetupImportView());

      await cubit.pickFile();
      await tester.pump();

      expect(find.text("! Couldn't open the file"), findsOneWidget);
    });

    testWidgets('counts the entries in the file that cannot be read', (
      tester,
    ) async {
      imports.error = const LedgerImportException([
        LedgerIssue(entry: 1, kind: LedgerIssueKind.badAmount),
        LedgerIssue(entry: 4, kind: LedgerIssueKind.unsupportedCost),
      ]);
      final cubit = await pumpSetup(tester, const SetupImportView());

      await cubit.pickFile();
      await tester.pump();

      expect(find.text("! Can't read 2 entries in this file"), findsOneWidget);
    });

    testWidgets('importing writes the chosen ledger', (tester) async {
      imports.draft = draftOf(fixtureTransactions);
      final cubit = await pumpSetup(tester, const SetupImportView());
      await cubit.pickFile();
      await tester.pump();

      await tester.tap(find.text('< import ${fixtureTransactions.length} >'));
      await tester.pumpAndSettle();

      expect(ledger.transactions, hasLength(fixtureTransactions.length));
    });

    testWidgets('a failed import keeps the file and offers another try', (
      tester,
    ) async {
      ledger = _RejectingReplace();
      imports.draft = draftOf(fixtureTransactions);
      final cubit = await pumpSetup(tester, const SetupImportView());
      await cubit.pickFile();
      await tester.pump();

      await tester.tap(find.text('< import ${fixtureTransactions.length} >'));
      await tester.pumpAndSettle();

      expect(find.text('ledger.json'), findsOneWidget);
      expect(
        find.text('< import ${fixtureTransactions.length} >'),
        findsOneWidget,
      );
    });
  });
}
