import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/repositories/rules/rules_repository.dart';
import 'package:ledger_app/domain/models/category_rule.dart';
import 'package:ledger_app/domain/models/rule_field.dart';
import 'package:ledger_app/domain/models/rule_issue.dart';
import 'package:ledger_app/ui/rules/view/rules_page.dart';

import '../../../../testing/fakes/fake_rules_repository.dart';
import '../../../../testing/fixtures/rules_fixtures.dart';
import '../../../../testing/widget_harness.dart';

Finder _rich(String text) => find.textContaining(text, findRichText: true);

void main() {
  Future<void> pumpRules(
    WidgetTester tester,
    FakeRulesRepository repository,
  ) async {
    await pumpApp(
      tester,
      home: const RulesPage(),
      wrap: (app) => RepositoryProvider<RulesRepository>.value(
        value: repository,
        child: app,
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows the file, when it was loaded and every rule', (
    tester,
  ) async {
    await pumpRules(
      tester,
      FakeRulesRepository(
        saved: ruleSet(
          issues: const [RuleIssue(line: 14, reason: RuleIssueReason.badRegex)],
        ),
      ),
    );

    expect(find.text('ledger.rules'), findsOneWidget);
    expect(find.text('2026-10-08 09:12'), findsOneWidget);
    expect(find.text('! 1'), findsOneWidget);
    expect(find.text('3 loaded'), findsOneWidget);
    expect(_rich('01 %payee Sample Property'), findsOneWidget);
    expect(_rich('03 %memo salary'), findsOneWidget);
    expect(_rich('-> income:salary'), findsOneWidget);
    expect(find.text('< replace file >'), findsOneWidget);
  });

  testWidgets('has no controls to edit a rule', (tester) async {
    await pumpRules(tester, FakeRulesRepository(saved: ruleSet()));

    expect(find.byType(Switch), findsNothing);
    expect(find.byType(TextField), findsNothing);
    expect(find.textContaining('delete'), findsNothing);
  });

  testWidgets('replacing the file swaps every rule', (tester) async {
    final repository = FakeRulesRepository(
      saved: ruleSet(),
      picked: ruleSet(
        fileName: 'new.rules',
        rules: const [
          CategoryRule(
            field: RuleField.any,
            pattern: 'coffee',
            account: 'expenses:food',
          ),
        ],
      ),
    );
    await pumpRules(tester, repository);

    await tester.tap(find.text('< replace file >'));
    await tester.pumpAndSettle();

    expect(find.text('new.rules'), findsOneWidget);
    expect(find.text('1 loaded'), findsOneWidget);
    expect(_rich('%any coffee'), findsOneWidget);
    expect(_rich('BTS|MRT|Grab'), findsNothing);
    expect(repository.saved?.fileName, 'new.rules');
  });

  testWidgets('a replacement without rules keeps the current ones', (
    tester,
  ) async {
    final repository = FakeRulesRepository(
      saved: ruleSet(),
      picked: ruleSet(fileName: 'empty.rules', rules: const []),
    );
    await pumpRules(tester, repository);

    await tester.tap(find.text('< replace file >'));
    await tester.pumpAndSettle();

    expect(find.text('No rules found in this file'), findsOneWidget);
    expect(find.text('ledger.rules'), findsOneWidget);
    expect(repository.saved?.fileName, 'ledger.rules');
  });

  testWidgets('without a file it offers to choose one', (tester) async {
    await pumpRules(tester, FakeRulesRepository(picked: ruleSet()));

    expect(find.text('# no rules file yet'), findsOneWidget);
    expect(find.text('< replace file >'), findsNothing);

    await tester.tap(find.text('< choose file >'));
    await tester.pumpAndSettle();

    expect(find.text('ledger.rules'), findsOneWidget);
    expect(find.text('3 loaded'), findsOneWidget);
  });
}
