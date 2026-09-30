import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/ui/reports/widgets/donut_chart.dart';

void main() {
  const size = Size(200, 200);

  group('donutSliceAt', () {
    test('finds the slice under a point, starting at 12 o\'clock', () {
      final weights = [75.0, 25.0];

      expect(donutSliceAt(const Offset(160, 100), size, weights), 0);
      expect(donutSliceAt(const Offset(100, 160), size, weights), 0);
      expect(donutSliceAt(const Offset(40, 120), size, weights), 0);
      expect(donutSliceAt(const Offset(70, 40), size, weights), 1);
    });

    test('ignores the hole and the outside', () {
      final weights = [1.0];

      expect(donutSliceAt(const Offset(100, 100), size, weights), isNull);
      expect(donutSliceAt(const Offset(1, 1), size, weights), isNull);
    });

    test('ignores empty charts', () {
      expect(donutSliceAt(const Offset(160, 100), size, []), isNull);
    });
  });

  testWidgets('tapping a slice reports its index', (tester) async {
    int? tapped;
    var centerTaps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 240,
              child: DonutChart(
                slices: const [
                  DonutSlice(
                    weight: 75,
                    color: Colors.red,
                    textColor: Colors.white,
                    name: 'Rent',
                    value: '75.0%',
                  ),
                  DonutSlice(
                    weight: 25,
                    color: Colors.blue,
                    textColor: Colors.white,
                    name: 'Food',
                    value: '25.0%',
                  ),
                ],
                center: const Text('centre'),
                onSliceTap: (index) => tapped = index,
                onCenterTap: () => centerTaps++,
              ),
            ),
          ),
        ),
      ),
    );
    final origin = tester.getTopLeft(find.byType(DonutChart));

    await tester.tapAt(origin + const Offset(120 + 100, 120));
    expect(tapped, 0);
    await tester.tapAt(origin + const Offset(120 - 30, 120 - 90));
    expect(tapped, 1);
    tapped = null;
    await tester.tapAt(origin + const Offset(120, 120));
    expect(tapped, isNull);
    expect(centerTaps, 1);
  });

  group('sweep animation', () {
    DonutSlice slice(double weight) => DonutSlice(
      weight: weight,
      color: Colors.red,
      textColor: Colors.white,
      name: 'Rent',
      value: '100.0%',
    );

    Future<void> pump(
      WidgetTester tester,
      List<DonutSlice> slices, {
      bool disableAnimations = false,
    }) => tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(disableAnimations: disableAnimations),
          child: child!,
        ),
        home: Scaffold(
          body: DonutChart(
            slices: slices,
            center: const SizedBox(),
            onSliceTap: (_) {},
          ),
        ),
      ),
    );

    testWidgets('does not animate on first show or unchanged slices', (
      tester,
    ) async {
      await pump(tester, [slice(1)]);
      expect(tester.hasRunningAnimations, isFalse);

      await pump(tester, [slice(1)]);
      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('sweeps in when the slices change', (tester) async {
      await pump(tester, [slice(1)]);
      await pump(tester, [slice(2)]);

      expect(tester.hasRunningAnimations, isTrue);
      await tester.pump(const Duration(milliseconds: 250));
      expect(tester.hasRunningAnimations, isTrue);
      await tester.pumpAndSettle();
      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('respects reduced motion', (tester) async {
      await pump(tester, [slice(1)], disableAnimations: true);
      await pump(tester, [slice(2)], disableAnimations: true);

      expect(tester.hasRunningAnimations, isFalse);
    });
  });
}
