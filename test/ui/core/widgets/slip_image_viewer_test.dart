import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/ui/core/widgets/slip_image_viewer.dart';
import 'package:ledger_app/ui/core/widgets/slip_thumbnail.dart';

import '../../../../testing/widget_harness.dart';

void main() {
  Future<void> openViewer(WidgetTester tester, String path) async {
    await pumpApp(
      tester,
      home: Scaffold(body: SlipThumbnail(imagePath: path)),
    );
    await tester.tap(find.byType(SlipThumbnail));
    await tester.pumpAndSettle();
  }

  testWidgets('tapping a thumbnail opens the slip full screen', (tester) async {
    await openViewer(tester, '/missing/slip.jpg');

    expect(find.byType(SlipImageViewer), findsOneWidget);
    expect(find.byType(InteractiveViewer), findsOneWidget);
  });

  testWidgets('says so when the image is no longer on the device', (
    tester,
  ) async {
    await openViewer(tester, '/missing/for-the-message.jpg');
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 300)),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    final message = find.text('This slip image is no longer on the device');
    expect(message, findsOneWidget);
    final screen = tester.view.physicalSize / tester.view.devicePixelRatio;
    expect(
      Offset.zero & screen,
      predicate<Rect>((r) => r.contains(tester.getCenter(message))),
    );
  });

  testWidgets('the back button closes the viewer', (tester) async {
    await openViewer(tester, '/missing/for-back.jpg');

    await tester.tap(find.text('q'));
    await tester.pumpAndSettle();

    expect(find.byType(SlipImageViewer), findsNothing);
    expect(find.byType(SlipThumbnail), findsOneWidget);
  });

  testWidgets('a missing thumbnail leaves an empty frame, not an error', (
    tester,
  ) async {
    await pumpApp(
      tester,
      home: const Scaffold(body: SlipThumbnail(imagePath: '/missing.jpg')),
    );
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.byType(SlipThumbnail), findsOneWidget);
  });
}
