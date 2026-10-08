import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/data/repositories/rules/rules_repository.dart';
import 'package:ledger_app/domain/models/rule_issue.dart';
import 'package:ledger_app/ui/setup/view/setup_rules_page.dart';

import '../../../../testing/fakes/fake_rules_repository.dart';
import '../../../../testing/fixtures/rules_fixtures.dart';
import '../../../../testing/widget_harness.dart';

Finder _rich(String text) => find.textContaining(text, findRichText: true);

void main() {
  Future<void> pumpRules(
    WidgetTester tester,
    FakeRulesRepository repository,
  ) async {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const SetupRulesPage()),
        GoRoute(
          path: '/setup/photos',
          builder: (_, _) => const Text('photos page'),
        ),
      ],
    );
    addTearDown(router.dispose);
    await pumpApp(
      tester,
      router: router,
      wrap: (app) => RepositoryProvider<RulesRepository>.value(
        value: repository,
        child: app,
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('starts on step 3 with the file format and a skip button', (
    tester,
  ) async {
    await pumpRules(tester, FakeRulesRepository());

    expect(find.text('step 3/4'), findsOneWidget);
    expect(find.text('optional'), findsOneWidget);
    expect(find.text('(none)'), findsOneWidget);
    expect(_rich('account2 expenses:rent'), findsOneWidget);
    expect(find.text('< skip >'), findsOneWidget);
    expect(find.text('< choose file >'), findsOneWidget);
    expect(find.textContaining('import'), findsNothing);
  });

  testWidgets('skipping goes on to the photos step', (tester) async {
    await pumpRules(tester, FakeRulesRepository());

    await tester.tap(find.text('< skip >'));
    await tester.pumpAndSettle();

    expect(find.text('photos page'), findsOneWidget);
  });

  testWidgets('a chosen file lists its rules and skipped lines', (
    tester,
  ) async {
    await pumpRules(
      tester,
      FakeRulesRepository(
        picked: ruleSet(
          issues: const [RuleIssue(line: 14, reason: RuleIssueReason.badRegex)],
        ),
      ),
    );

    await tester.tap(find.text('< choose file >'));
    await tester.pumpAndSettle();

    expect(find.text('ledger.rules'), findsOneWidget);
    expect(find.text('rules found'), findsOneWidget);
    expect(find.text('✓ 3'), findsOneWidget);
    expect(_rich('%payee BTS|MRT|Grab'), findsOneWidget);
    expect(_rich('expenses:transport'), findsOneWidget);
    expect(find.text('! line 14 skipped'), findsOneWidget);
    expect(find.text('bad regex'), findsOneWidget);
    expect(find.text('< choose another file >'), findsOneWidget);
    expect(find.text('< import 3 rules >'), findsOneWidget);
    expect(find.text('< skip >'), findsOneWidget);
    expect(_rich('account2 expenses:rent'), findsNothing);
  });

  testWidgets('importing saves the rules and opens the photos step', (
    tester,
  ) async {
    final repository = FakeRulesRepository(picked: ruleSet());
    await pumpRules(tester, repository);
    await tester.tap(find.text('< choose file >'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('< import 3 rules >'));
    await tester.pumpAndSettle();

    expect(repository.saved?.rules, fixtureRules);
    expect(find.text('photos page'), findsOneWidget);
  });

  testWidgets('skipping after choosing a file saves nothing', (tester) async {
    final repository = FakeRulesRepository(picked: ruleSet());
    await pumpRules(tester, repository);
    await tester.tap(find.text('< choose file >'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('< skip >'));
    await tester.pumpAndSettle();

    expect(repository.saved, isNull);
    expect(find.text('photos page'), findsOneWidget);
  });

  testWidgets('a file without rules cannot be imported', (tester) async {
    await pumpRules(
      tester,
      FakeRulesRepository(
        picked: ruleSet(
          rules: const [],
          issues: const [
            RuleIssue(line: 1, reason: RuleIssueReason.unknownDirective),
          ],
        ),
      ),
    );

    await tester.tap(find.text('< choose file >'));
    await tester.pumpAndSettle();

    expect(find.text('No rules found in this file'), findsOneWidget);
    expect(find.textContaining('< import'), findsNothing);
    expect(find.text('< skip >'), findsOneWidget);
  });

  testWidgets('a file that cannot be opened says so', (tester) async {
    await pumpRules(tester, FakeRulesRepository(pickError: Exception('x')));

    await tester.tap(find.text('< choose file >'));
    await tester.pumpAndSettle();

    expect(find.text("Couldn't open the file"), findsOneWidget);
    expect(find.text('(none)'), findsOneWidget);
  });
}
