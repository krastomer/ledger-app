import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/repositories/rules/rules_repository.dart';
import 'package:ledger_app/ui/settings/widgets/rules_tile.dart';

import '../../../../testing/fakes/fake_rules_repository.dart';
import '../../../../testing/fixtures/rules_fixtures.dart';
import '../../../../testing/widget_harness.dart';

Finder _rich(String text) => find.textContaining(text, findRichText: true);

void main() {
  Future<void> pumpTile(
    WidgetTester tester,
    FakeRulesRepository repository,
  ) async {
    await pumpApp(
      tester,
      router: stubRouter(
        const Scaffold(body: RulesTile()),
        paths: ['/settings/rules'],
      ),
      wrap: (app) => RepositoryProvider<RulesRepository>.value(
        value: repository,
        child: app,
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('says there is no file yet', (tester) async {
    await pumpTile(tester, FakeRulesRepository());

    expect(_rich('rules = (none)'), findsOneWidget);
    expect(find.text('# no rules file yet'), findsOneWidget);
  });

  testWidgets('shows the saved file and how many rules it gave', (
    tester,
  ) async {
    await pumpTile(tester, FakeRulesRepository(saved: ruleSet()));

    expect(_rich('rules = "ledger.rules"'), findsOneWidget);
    expect(find.text('# 3 loaded · view or replace'), findsOneWidget);
  });

  testWidgets('opens the rules page and reloads when it comes back', (
    tester,
  ) async {
    final repository = FakeRulesRepository(saved: ruleSet());
    await pumpTile(tester, repository);

    await tester.tap(_rich('rules = '));
    await tester.pumpAndSettle();
    expect(find.text('at /settings/rules'), findsOneWidget);

    repository.saved = ruleSet(fileName: 'other.rules');
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pop();
    await tester.pumpAndSettle();

    expect(_rich('rules = "other.rules"'), findsOneWidget);
  });
}
