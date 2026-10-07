import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/ui/core/themes/app_scroll_behavior.dart';

void main() {
  testWidgets(
    'a page stays put when dragged past its edges',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          scrollBehavior: const AppScrollBehavior(),
          home: RefreshIndicator(
            onRefresh: () async {},
            child: ListView(children: const [Text('row')]),
          ),
        ),
      );
      final row = find.text('row');
      final resting = tester.getTopLeft(row);
      final gesture = await tester.startGesture(tester.getCenter(row));

      await gesture.moveBy(const Offset(0, 200));
      await tester.pump();
      expect(tester.getTopLeft(row), resting);

      await gesture.moveBy(const Offset(0, -400));
      await tester.pump();
      expect(tester.getTopLeft(row), resting);

      await gesture.cancel();
    },
    variant: const TargetPlatformVariant({
      TargetPlatform.android,
      TargetPlatform.iOS,
    }),
  );
}
