import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/ui/setup/bloc/setup_cubit.dart';
import 'package:ledger_app/ui/setup/widgets/setup_listener.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../../testing/fakes/fake_ledger_import_repository.dart';
import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fakes/fake_settings_repository.dart';
import '../../../../testing/widget_harness.dart';

class _RejectingReplace extends FakeLedgerRepository {
  @override
  Future<Result<void>> replaceAll({
    required List<Account> accounts,
    required List<LedgerTransaction> transactions,
  }) async => Result.error(Exception('disk'));
}

void main() {
  late FakeSettingsRepository settings;

  setUp(() => settings = FakeSettingsRepository());

  Future<SetupCubit> pumpListener(
    WidgetTester tester,
    FakeLedgerRepository ledger,
  ) async {
    final cubit = SetupCubit(
      importRepository: FakeLedgerImportRepository(),
      ledgerRepository: ledger,
    );
    addTearDown(cubit.close);
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/setup/rules',
          builder: (_, _) => const Scaffold(body: Text('rules')),
        ),
        GoRoute(
          path: '/setup',
          builder: (_, _) => BlocProvider<SetupCubit>.value(
            value: cubit,
            child: const SetupListener(
              child: Scaffold(body: Text('setting up')),
            ),
          ),
        ),
      ],
      initialLocation: '/setup',
    );
    addTearDown(router.dispose);
    await pumpApp(tester, router: router, settingsRepository: settings);
    await tester.pumpAndSettle();
    return cubit;
  }

  testWidgets('creating the ledger opens the rules step', (tester) async {
    final cubit = await pumpListener(tester, FakeLedgerRepository());

    await cubit.startNew();
    await tester.pumpAndSettle();

    expect(find.text('rules'), findsOneWidget);
    expect(settings.saved.setupComplete, isFalse);
  });

  testWidgets('a failed save stays on the screen with a message', (
    tester,
  ) async {
    final cubit = await pumpListener(tester, _RejectingReplace());

    await cubit.startNew();
    await tester.pump();

    expect(find.text("Couldn't set up the ledger"), findsOneWidget);
    expect(find.text('setting up'), findsOneWidget);
    expect(settings.saved.setupComplete, isFalse);
  });

  testWidgets('says nothing while setup is still working', (tester) async {
    final cubit = await pumpListener(tester, FakeLedgerRepository());

    unawaited(cubit.pickFile());
    await tester.pump();

    expect(find.byType(SnackBar), findsNothing);
    expect(find.text('setting up'), findsOneWidget);
  });
}
