import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/data/repositories/gallery/gallery_repository.dart';
import 'package:ledger_app/domain/models/gallery_access.dart';
import 'package:ledger_app/domain/models/gallery_album.dart';
import 'package:ledger_app/domain/models/gallery_look_back.dart';
import 'package:ledger_app/ui/setup/view/setup_photos_page.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../../testing/fakes/fake_gallery_repository.dart';
import '../../../../testing/fakes/fake_settings_repository.dart';
import '../../../../testing/widget_harness.dart';

const _albums = [
  GalleryAlbum(
    id: 'all',
    name: 'Recents',
    count: 1284,
    kind: GalleryAlbumKind.recents,
  ),
  GalleryAlbum(
    id: 'shots',
    name: 'Screenshots',
    count: 214,
    kind: GalleryAlbumKind.screenshots,
  ),
  GalleryAlbum(
    id: 'kplus',
    name: 'K PLUS',
    count: 38,
    kind: GalleryAlbumKind.other,
  ),
  GalleryAlbum(
    id: 'trip',
    name: 'Trip',
    count: 9,
    kind: GalleryAlbumKind.other,
  ),
];

Finder _sync() => find.textContaining('sync_gallery', findRichText: true);

void main() {
  late FakeSettingsRepository settings;

  setUp(() => settings = FakeSettingsRepository(saved: englishSettings));

  Future<void> pumpPhotos(
    WidgetTester tester, {
    FakeGalleryRepository? gallery,
    bool syncOn = false,
  }) async {
    if (syncOn) settings.saved = settings.saved.copyWith(syncGallery: true);
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const Text('home')),
        GoRoute(
          path: '/setup/photos',
          builder: (_, _) => const SetupPhotosPage(),
        ),
        GoRoute(path: '/setup/scan', builder: (_, _) => const Text('scan')),
      ],
      initialLocation: '/setup/photos',
    );
    addTearDown(router.dispose);
    await pumpApp(
      tester,
      router: router,
      settingsRepository: settings,
      settings: settings.saved,
      wrap: (app) => RepositoryProvider<GalleryRepository>.value(
        value: gallery ?? FakeGalleryRepository(albums: _albums),
        child: app,
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> turnSyncOn(WidgetTester tester) async {
    await tester.tap(_sync());
    await tester.pumpAndSettle();
  }

  testWidgets('leaves the gallery off and lists no albums by default', (
    tester,
  ) async {
    await pumpPhotos(tester);

    expect(find.text('step 4/4'), findsOneWidget);
    expect(find.text('Recents'), findsNothing);
    expect(find.text('look back'), findsNothing);
    expect(find.text('< finish >'), findsOneWidget);
  });

  testWidgets('ticking sync_gallery lists the albums of the device', (
    tester,
  ) async {
    await pumpPhotos(tester);

    await turnSyncOn(tester);

    expect(settings.saved.syncGallery, isTrue);
    for (final name in ['Recents', 'Screenshots', 'K PLUS', 'Trip']) {
      expect(find.text(name), findsOneWidget);
    }
    expect(find.text('1,284 photos · everything, slower'), findsOneWidget);
    expect(find.text('214 photos · system album'), findsOneWidget);
    expect(find.text('38 photos · named like a bank app'), findsOneWidget);
    expect(find.text('9 photos'), findsOneWidget);
  });

  testWidgets('only the album it is sure about is ticked, the bank one is '
      'suggested', (tester) async {
    await pumpPhotos(tester);

    await turnSyncOn(tester);

    expect(settings.saved.galleryAlbumIds, ['shots']);
    expect(find.text('[x]'), findsNWidgets(2));
    expect(find.text('[ ]'), findsNWidgets(3));
    expect(find.text('suggested'), findsOneWidget);
  });

  testWidgets('tapping an album ticks and unticks it', (tester) async {
    await pumpPhotos(tester);
    await turnSyncOn(tester);

    await tester.tap(find.text('K PLUS'));
    await tester.pumpAndSettle();
    expect(settings.saved.galleryAlbumIds, ['shots', 'kplus']);

    await tester.tap(find.text('Screenshots'));
    await tester.pumpAndSettle();
    expect(settings.saved.galleryAlbumIds, ['kplus']);
  });

  testWidgets('with nothing ticked it says Recents is used', (tester) async {
    await pumpPhotos(tester);
    await turnSyncOn(tester);
    expect(find.textContaining('nothing picked'), findsNothing);

    await tester.tap(find.text('Screenshots'));
    await tester.pumpAndSettle();

    expect(
      find.text('# nothing picked: Recents for the last 90 days'),
      findsOneWidget,
    );
  });

  testWidgets('look back is chosen and saved', (tester) async {
    await pumpPhotos(tester);
    await turnSyncOn(tester);

    await tester.tap(find.text('30 days'));
    await tester.pumpAndSettle();

    expect(settings.saved.galleryLookBack, GalleryLookBack.days30);
  });

  testWidgets('a choice made earlier is kept when the albums load', (
    tester,
  ) async {
    settings.saved = settings.saved.copyWith(galleryAlbumIds: ['trip']);

    await pumpPhotos(tester);
    await turnSyncOn(tester);

    expect(settings.saved.galleryAlbumIds, ['trip']);
  });

  testWidgets('says so when photo access is denied', (tester) async {
    await pumpPhotos(
      tester,
      gallery: FakeGalleryRepository(
        access: const Result.ok(GalleryAccess.denied),
      ),
    );

    await turnSyncOn(tester);

    expect(find.textContaining('No access to your photos'), findsOneWidget);
    expect(find.text('Recents'), findsNothing);
  });

  testWidgets('says so when the albums cannot be read', (tester) async {
    await pumpPhotos(
      tester,
      gallery: FakeGalleryRepository(albumsError: Exception('x')),
    );

    await turnSyncOn(tester);

    expect(find.textContaining("Couldn't read the albums"), findsOneWidget);
  });

  testWidgets('limited access warns and can share more photos', (tester) async {
    final gallery = FakeGalleryRepository(
      albums: _albums,
      access: const Result.ok(GalleryAccess.limited),
    );
    await pumpPhotos(tester, gallery: gallery);

    await turnSyncOn(tester);
    expect(
      find.textContaining('limited access · only the photos you shared'),
      findsOneWidget,
    );

    await tester.tap(find.text('< select more >'));
    await tester.pumpAndSettle();
    expect(gallery.selectMoreCalls, 1);
  });

  testWidgets('full access shows no limited warning', (tester) async {
    await pumpPhotos(tester);

    await turnSyncOn(tester);

    expect(find.textContaining('limited access'), findsNothing);
  });

  testWidgets('shows how the scan works once the gallery is on', (
    tester,
  ) async {
    await pumpPhotos(tester);
    expect(find.text('how it works'), findsNothing);

    await turnSyncOn(tester);

    expect(find.text('how it works'), findsOneWidget);
  });

  testWidgets('comes back with the albums when the gallery was already on', (
    tester,
  ) async {
    await pumpPhotos(tester, syncOn: true);

    expect(find.text('Recents'), findsOneWidget);
  });

  testWidgets('with the gallery on, scan photos opens the scan', (
    tester,
  ) async {
    await pumpPhotos(tester);
    await turnSyncOn(tester);

    await tester.tap(find.text('< scan photos >'));
    await tester.pumpAndSettle();

    expect(find.text('scan'), findsOneWidget);
    expect(settings.saved.setupComplete, isFalse);
  });

  testWidgets('finish completes setup and opens Home', (tester) async {
    await pumpPhotos(tester);

    await tester.tap(find.text('< finish >'));
    await tester.pumpAndSettle();

    expect(settings.saved.setupComplete, isTrue);
    expect(find.text('home'), findsOneWidget);
  });
}
