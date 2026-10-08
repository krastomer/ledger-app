import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/gallery_access.dart';
import 'package:ledger_app/domain/models/gallery_sync_scope.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/ui/setup/bloc/setup_scan_cubit.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../../testing/fakes/fake_gallery_repository.dart';
import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fakes/fake_slip_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';
import '../../../../testing/fixtures/slip_draft_fixtures.dart';

class _RejectingWrites extends FakeLedgerRepository {
  _RejectingWrites({super.accounts, super.transactions});

  @override
  Future<Result<void>> save(LedgerTransaction transaction) async =>
      Result.error(Exception('read only'));
}

void main() {
  late FakeLedgerRepository ledger;

  setUp(() {
    ledger = FakeLedgerRepository(
      accounts: fixtureAccounts,
      transactions: fixtureTransactions,
    );
  });

  SetupScanCubit build({
    FakeGalleryRepository? gallery,
    FakeLedgerRepository? ledgerRepository,
    GallerySyncScope scope = GallerySyncScope.screenshots,
  }) => SetupScanCubit(
    galleryRepository:
        gallery ??
        FakeGalleryRepository(
          libraryCount: 40,
          photos: {
            'rent': 'rent.jpg',
            'food': 'food.jpg',
            'noise': 'cat.jpg',
            'again': 'again.jpg',
            'old': 'old.jpg',
            'lost': 'lost.jpg',
            'blank': 'blank.jpg',
          },
        ),
    importSlip: ImportSlipUseCase(
      slipRepository: FakeSlipRepository({
        'rent.jpg': transferSlip(reference: 'REF-RENT'),
        'food.jpg': transferSlip(reference: 'REF-FOOD', satang: 6000),
        'again.jpg': transferSlip(reference: 'REF-RENT'),
        'old.jpg': transferSlip(reference: 'REF-1'),
        'blank.jpg': transferSlip(reference: 'REF-BLANK', satang: null),
      }),
      ledgerRepository: ledgerRepository ?? ledger,
      now: () => fixtureToday,
    ),
    scope: scope,
  );

  group('scan', () {
    blocTest<SetupScanCubit, SetupScanState>(
      'fails with noAccess when photo access is denied',
      build: () => build(
        gallery: FakeGalleryRepository(
          access: const Result.ok(GalleryAccess.denied),
        ),
      ),
      act: (cubit) => cubit.scan(),
      expect: () => [
        isA<SetupScanState>()
            .having((s) => s.phase, 'phase', SetupScanPhase.failed)
            .having((s) => s.error, 'error', SetupScanError.noAccess),
      ],
    );

    blocTest<SetupScanCubit, SetupScanState>(
      'fails with listFailed when the library cannot be read',
      build: () => build(
        gallery: FakeGalleryRepository(listError: Exception('no library')),
      ),
      act: (cubit) => cubit.scan(),
      expect: () => [
        isA<SetupScanState>().having(
          (s) => s.error,
          'error',
          SetupScanError.listFailed,
        ),
      ],
    );

    blocTest<SetupScanCubit, SetupScanState>(
      'works with limited photo access',
      build: () => build(
        gallery: FakeGalleryRepository(
          access: const Result.ok(GalleryAccess.limited),
          photos: {'rent': 'rent.jpg'},
        ),
      ),
      act: (cubit) => cubit.scan(),
      verify: (cubit) => expect(cubit.state.found, hasLength(1)),
    );

    test('lists the photos in the chosen scope', () async {
      final gallery = FakeGalleryRepository();
      final cubit = build(gallery: gallery, scope: GallerySyncScope.all);
      addTearDown(cubit.close);

      await cubit.scan();

      expect(gallery.listedScope, GallerySyncScope.all);
    });

    test('keeps slips and skips what is not a new slip', () async {
      final cubit = build();
      addTearDown(cubit.close);

      await cubit.scan();

      expect(cubit.state.phase, SetupScanPhase.scanned);
      expect(cubit.state.libraryCount, 40);
      expect(cubit.state.toCheck, 7);
      expect(cubit.state.checked, 7);
      expect([
        for (final slip in cubit.state.found) slip.id,
      ], unorderedEquals(['rent.jpg', 'food.jpg', 'blank.jpg']));
    });

    test('keeps one of two photos of the same slip', () async {
      final cubit = build();
      addTearDown(cubit.close);

      await cubit.scan();

      expect(
        cubit.state.found.where((slip) => slip.id == 'again.jpg'),
        isEmpty,
      );
    });

    test('selects every slip that has an amount', () async {
      final cubit = build();
      addTearDown(cubit.close);

      await cubit.scan();

      expect(cubit.state.selected, {'rent.jpg', 'food.jpg'});
    });

    test('reports progress one photo at a time', () async {
      final cubit = build(
        gallery: FakeGalleryRepository(
          photos: {'rent': 'rent.jpg', 'food': 'food.jpg'},
        ),
      );
      addTearDown(cubit.close);
      final checked = <int>[];
      cubit.stream.listen((state) => checked.add(state.checked));

      await cubit.scan();
      await pumpEventQueue();

      expect(checked, containsAllInOrder([0, 1, 2]));
    });

    test('stops reading photos once closed', () async {
      final cubit = build();

      final scan = cubit.scan();
      await cubit.close();
      await scan;

      expect(cubit.state.phase, isNot(SetupScanPhase.scanned));
    });
  });

  group('review', () {
    Future<SetupScanCubit> scanned() async {
      final cubit = build();
      addTearDown(cubit.close);
      await cubit.scan();
      cubit.review();
      return cubit;
    }

    test('opens the list of found slips', () async {
      final cubit = await scanned();

      expect(cubit.state.phase, SetupScanPhase.review);
      expect(cubit.state.inReview, isTrue);
    });

    test('toggle flips one slip', () async {
      final cubit = await scanned();

      cubit.toggle('rent.jpg');
      expect(cubit.state.selected, {'food.jpg'});

      cubit.toggle('rent.jpg');
      expect(cubit.state.selected, {'food.jpg', 'rent.jpg'});
    });

    test('a slip without an amount cannot be selected', () async {
      final cubit = await scanned();

      cubit.toggle('blank.jpg');

      expect(cubit.state.selected, isNot(contains('blank.jpg')));
    });

    test('selectAll picks every importable slip, or none', () async {
      final cubit = await scanned();

      cubit.selectAll(false);
      expect(cubit.state.selected, isEmpty);

      cubit.selectAll(true);
      expect(cubit.state.selected, {'rent.jpg', 'food.jpg'});
    });

    test('importing saves the selected slips as pending entries', () async {
      final cubit = await scanned();
      final before = ledger.transactions.length;
      cubit.toggle('food.jpg');

      await cubit.importSelected();

      expect(cubit.state.phase, SetupScanPhase.done);
      expect(ledger.transactions, hasLength(before + 1));
      expect(ledger.transactions.last.code, 'REF-RENT');
      expect(ledger.transactions.last.status.name, 'pending');
    });

    test('skip finishes without saving', () async {
      final cubit = await scanned();
      final before = ledger.transactions.length;

      cubit.skip();

      expect(cubit.state.phase, SetupScanPhase.done);
      expect(ledger.transactions, hasLength(before));
    });

    test('a failed save goes back to the list with an error', () async {
      final rejecting = _RejectingWrites(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      );
      final cubit = build(ledgerRepository: rejecting);
      addTearDown(cubit.close);
      await cubit.scan();
      cubit.review();

      await cubit.importSelected();

      expect(cubit.state.phase, SetupScanPhase.review);
      expect(cubit.state.error, SetupScanError.saveFailed);
      expect(cubit.state.selected, {'rent.jpg', 'food.jpg'});
    });
  });
}
