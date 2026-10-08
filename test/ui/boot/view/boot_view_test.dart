import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/use_cases/ledger_check_use_case.dart';
import 'package:ledger_app/ui/boot/bloc/boot_cubit.dart';
import 'package:ledger_app/ui/boot/view/boot_view.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';
import '../../../../testing/widget_harness.dart';

void main() {
  Future<void> pumpBoot(WidgetTester tester, {required bool firstRun}) async {
    final cubit = BootCubit(
      ledgerCheck: LedgerCheckUseCase(
        ledgerRepository: FakeLedgerRepository(
          accounts: fixtureAccounts,
          transactions: fixtureTransactions,
        ),
      ),
      isFirstRun: firstRun,
    );
    addTearDown(cubit.close);
    await cubit.run();
    await pumpApp(
      tester,
      router: stubRouter(const BootView(), paths: ['/setup', '/home']),
      wrap: (app) => BlocProvider.value(value: cubit, child: app),
    );
    await tester.pump();
  }

  group('first run', () {
    testWidgets('logs that there is no ledger instead of ledger statistics', (
      tester,
    ) async {
      await pumpBoot(tester, firstRun: true);
      await tester.pump(const Duration(seconds: 2));

      expect(find.textContaining('Started ledger'), findsOneWidget);
      expect(find.textContaining('No ledger on this device'), findsOneWidget);
      expect(find.textContaining('Starting first-run setup'), findsOneWidget);
      expect(find.textContaining('Opened ledger'), findsNothing);
    });

    testWidgets('waits for the user to tap set up, with no countdown', (
      tester,
    ) async {
      await pumpBoot(tester, firstRun: true);

      await tester.pump(const Duration(seconds: 10));

      expect(find.text('< set up >'), findsOneWidget);
      expect(find.textContaining('continue'), findsNothing);
      expect(find.textContaining('at /setup'), findsNothing);
      expect(
        find.text('# takes about a minute · nothing leaves this phone'),
        findsOneWidget,
      );
    });

    testWidgets('set up opens the setup', (tester) async {
      await pumpBoot(tester, firstRun: true);

      await tester.tap(find.text('< set up >'));
      await tester.pumpAndSettle();

      expect(find.text('at /setup'), findsOneWidget);
    });
  });

  testWidgets('after setup it still counts down before continuing', (
    tester,
  ) async {
    await pumpBoot(tester, firstRun: false);

    await tester.pump(const Duration(milliseconds: 2100));
    await tester.pump();

    expect(find.textContaining('Opened ledger'), findsOneWidget);
    expect(find.textContaining('continue (2s)'), findsOneWidget);
    expect(find.text('< set up >'), findsNothing);
  });
}
