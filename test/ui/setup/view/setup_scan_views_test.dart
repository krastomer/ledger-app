import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/domain/models/found_slip.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/ui/setup/bloc/setup_scan_cubit.dart';
import 'package:ledger_app/ui/setup/view/setup_scan_view.dart';
import 'package:ledger_app/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fakes/fake_settings_repository.dart';
import '../../../../testing/fakes/fake_slip_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';
import '../../../../testing/fixtures/slip_draft_fixtures.dart';
import '../../../../testing/widget_harness.dart';

class _MockScanCubit extends MockCubit<SetupScanState>
    implements SetupScanCubit {}

void main() {
  late _MockScanCubit cubit;
  late FakeSettingsRepository settings;
  late List<FoundSlip> slips;

  setUp(() async {
    cubit = _MockScanCubit();
    settings = FakeSettingsRepository();
    final importSlip = ImportSlipUseCase(
      slipRepository: FakeSlipRepository({
        'rent.jpg': transferSlip(reference: 'REF-RENT'),
        'food.jpg': transferSlip(
          reference: 'REF-FOOD',
          satang: 6000,
          payee: 'Rice shop',
        ),
        'blank.jpg': transferSlip(reference: 'REF-BLANK', satang: null),
      }),
      ledgerRepository: FakeLedgerRepository(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      ),
      now: () => fixtureToday,
    );
    slips = [
      for (final path in ['rent.jpg', 'food.jpg', 'blank.jpg'])
        switch (await importSlip.read(path)) {
          Ok(:final value) => FoundSlip(draft: value),
          Error(:final error) => throw error,
        },
    ];
  });

  void stubState(SetupScanState state) {
    when(() => cubit.state).thenReturn(state);
    when(() => cubit.importSelected()).thenAnswer((_) async {});
    whenListen(
      cubit,
      const Stream<SetupScanState>.empty(),
      initialState: state,
    );
  }

  Future<void> pumpScan(WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const Text('home')),
        GoRoute(
          path: '/setup/scan',
          builder: (_, _) => BlocProvider<SetupScanCubit>.value(
            value: cubit,
            child: const SetupScanView(),
          ),
        ),
      ],
      initialLocation: '/setup/scan',
    );
    addTearDown(router.dispose);
    await pumpApp(tester, router: router, settingsRepository: settings);
    await tester.pumpAndSettle();
  }

  group('scanning', () {
    testWidgets('shows how far the scan has come', (tester) async {
      stubState(
        const SetupScanState(
          phase: SetupScanPhase.scanning,
          libraryCount: 1284,
          toCheck: 214,
          checked: 80,
        ),
      );

      await pumpScan(tester);

      expect(find.textContaining('1,284 photos in library'), findsOneWidget);
      expect(find.textContaining('214 screenshots to check'), findsOneWidget);
      expect(find.textContaining('read text from 80 of 214'), findsOneWidget);
      expect(find.text('step 3/3'), findsOneWidget);
      expect(find.text('< scanning... >'), findsOneWidget);
      expect(find.text('cancel'), findsOneWidget);
    });

    testWidgets('offers the slips found once the scan is done', (tester) async {
      stubState(
        SetupScanState(
          phase: SetupScanPhase.scanned,
          libraryCount: 20,
          toCheck: 5,
          checked: 5,
          found: slips,
        ),
      );
      await pumpScan(tester);

      expect(find.textContaining('3 slips found'), findsOneWidget);
      await tester.tap(find.text('< review 3 found >'));

      verify(() => cubit.review()).called(1);
    });

    testWidgets('finishes setup when no slip was found', (tester) async {
      stubState(
        const SetupScanState(
          phase: SetupScanPhase.scanned,
          libraryCount: 20,
          toCheck: 5,
          checked: 5,
        ),
      );
      await pumpScan(tester);

      await tester.tap(find.text('< finish >'));
      await tester.pumpAndSettle();

      expect(settings.saved.setupComplete, isTrue);
      expect(find.text('home'), findsOneWidget);
    });

    testWidgets('explains a missing photo permission', (tester) async {
      stubState(
        const SetupScanState(
          phase: SetupScanPhase.failed,
          error: SetupScanError.noAccess,
        ),
      );

      await pumpScan(tester);

      expect(find.textContaining('No access to your photos'), findsOneWidget);
      expect(find.textContaining('system settings'), findsOneWidget);
      expect(find.text('< finish >'), findsOneWidget);
    });

    testWidgets('says when the library could not be read', (tester) async {
      stubState(
        const SetupScanState(
          phase: SetupScanPhase.failed,
          error: SetupScanError.listFailed,
        ),
      );

      await pumpScan(tester);

      expect(
        find.textContaining("Couldn't read the photo library"),
        findsWidgets,
      );
    });
  });

  group('found slips', () {
    SetupScanState review({
      Set<String>? selected,
      SetupScanPhase phase = SetupScanPhase.review,
    }) => SetupScanState(
      phase: phase,
      found: slips,
      selected: selected ?? {'rent.jpg', 'food.jpg'},
    );

    testWidgets('lists slips by kind with how many are selected', (
      tester,
    ) async {
      stubState(review());

      await pumpScan(tester);

      expect(find.text('2 of 3 selected'), findsOneWidget);
      expect(find.text('transfers'), findsOneWidget);
      expect(find.text('2/2'), findsOneWidget);
      expect(find.text('not sure'), findsOneWidget);
      expect(find.text('0/1'), findsOneWidget);
      expect(find.text('Rice shop'), findsOneWidget);
      expect(find.text('looks like a slip, no amount'), findsOneWidget);
    });

    testWidgets('tapping a slip toggles it', (tester) async {
      stubState(review());
      await pumpScan(tester);

      await tester.tap(find.text('Rice shop'));

      verify(() => cubit.toggle('food.jpg')).called(1);
    });

    testWidgets('a slip without an amount cannot be toggled', (tester) async {
      stubState(review());
      await pumpScan(tester);

      await tester.tap(find.text('looks like a slip, no amount'));

      verifyNever(() => cubit.toggle(any()));
    });

    testWidgets('select none clears the selection', (tester) async {
      stubState(review());
      await pumpScan(tester);

      await tester.tap(find.text('< select none >'));

      verify(() => cubit.selectAll(false)).called(1);
    });

    testWidgets('select all picks everything when some are unticked', (
      tester,
    ) async {
      stubState(review(selected: {'rent.jpg'}));
      await pumpScan(tester);

      await tester.tap(find.text('< select all >'));

      verify(() => cubit.selectAll(true)).called(1);
    });

    testWidgets('import saves the selected slips', (tester) async {
      stubState(review());
      await pumpScan(tester);

      await tester.tap(find.text('< import 2 >'));

      verify(() => cubit.importSelected()).called(1);
    });

    testWidgets('skip replaces import when nothing is selected', (
      tester,
    ) async {
      stubState(review(selected: {}));
      await pumpScan(tester);

      await tester.tap(find.text('< skip >'));

      verify(() => cubit.skip()).called(1);
    });

    testWidgets('cannot be tapped again while saving', (tester) async {
      stubState(review(phase: SetupScanPhase.saving));
      await pumpScan(tester);

      await tester.tap(find.text('< import 2 >'), warnIfMissed: false);

      verifyNever(() => cubit.importSelected());
    });

    testWidgets('completes setup and opens Home once saved', (tester) async {
      stubState(review());
      final states = Stream.value(review(phase: SetupScanPhase.done));
      whenListen(cubit, states, initialState: review());
      await pumpScan(tester);
      await tester.pumpAndSettle();

      expect(settings.saved.setupComplete, isTrue);
      expect(find.text('home'), findsOneWidget);
    });
  });
}
