import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/repositories/rules/rules_repository.dart';
import 'package:ledger_app/ui/settings/view/settings_view.dart';

import '../../../../testing/fakes/fake_rules_repository.dart';
import '../../../../testing/fakes/fake_settings_repository.dart';
import '../../../../testing/widget_harness.dart';

Finder _key(String name) => find.textContaining(name, findRichText: true);

void main() {
  Future<void> pumpSettings(
    WidgetTester tester, {
    FakeSettingsRepository? repository,
  }) async {
    await pumpApp(
      tester,
      home: const SettingsView(),
      wrap: (app) => RepositoryProvider<RulesRepository>.value(
        value: FakeRulesRepository(),
        child: app,
      ),
      settingsRepository: repository,
    );
    tester.view
      ..physicalSize = const Size(402, 2400)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pump();
  }

  group('rows that are not built yet', () {
    for (final (label, finder) in [
      ('hidden accounts', _key('hidden_accounts')),
      ('home cards', _key('home_cards')),
      ('back up', find.text('< back up >')),
      ('restore', find.text('< restore >')),
    ]) {
      testWidgets('$label say so when tapped', (tester) async {
        await pumpSettings(tester);

        await tester.ensureVisible(finder);
        await tester.tap(finder);
        await tester.pump();

        expect(find.text('Coming soon'), findsOneWidget);
      });
    }
  });

  testWidgets('keeping slip images can be turned off', (tester) async {
    final repository = FakeSettingsRepository();
    await pumpSettings(tester, repository: repository);

    await tester.ensureVisible(_key('keep_slip_images'));
    await tester.tap(_key('keep_slip_images'));
    await tester.pumpAndSettle();

    expect(repository.saved.keepSlipImages, isFalse);
  });

  testWidgets('hiding amounts on launch is saved', (tester) async {
    final repository = FakeSettingsRepository();
    await pumpSettings(tester, repository: repository);

    await tester.tap(_key('hide_on_launch'));
    await tester.pumpAndSettle();

    expect(repository.saved.hideOnLaunch, isTrue);
  });

  testWidgets('a setting that cannot be saved snaps back with a message', (
    tester,
  ) async {
    final repository = FakeSettingsRepository(error: Exception('disk'));
    await pumpSettings(tester, repository: repository);

    await tester.tap(_key('hide_on_launch'));
    await tester.pump();
    await tester.pump();

    expect(find.text("Couldn't save the setting"), findsOneWidget);
    expect(repository.saved.hideOnLaunch, isFalse);
  });
}
