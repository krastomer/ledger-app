import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/ui/accounts/view/account_rows.dart';
import 'package:ledger_app/ui/accounts/widgets/account_row.dart';
import 'package:ledger_app/ui/core/widgets/tui_bar.dart';
import 'package:ledger_app/ui/core/widgets/tui_cell.dart';
import 'package:ledger_app/ui/core/widgets/tui_dashed_line.dart';
import 'package:ledger_app/ui/core/widgets/tui_shade.dart';

import '../../../../testing/fixtures/ledger_fixtures.dart';
import '../../../../testing/widget_harness.dart';

CustomPainter? _painterOf(WidgetTester tester, Type widget) => tester
    .widget<CustomPaint>(
      find.descendant(
        of: find.byType(widget),
        matching: find.byType(CustomPaint),
      ),
    )
    .painter;

void main() {
  group('TuiBar.share', () {
    test('is the part of the whole between 0 and 1', () {
      expect(TuiBar.share(thb(250), thb(1000)), 0.25);
      expect(TuiBar.share(thb(1000), thb(1000)), 1);
    });

    test('never goes past a full bar or below an empty one', () {
      expect(TuiBar.share(thb(3000), thb(1000)), 1);
      expect(TuiBar.share(thb(-5), thb(1000)), 0);
    });

    test('is empty when there is no whole to compare with', () {
      expect(TuiBar.share(thb(5), thb(0)), 0);
      expect(TuiBar.share(thb(5), thb(-10)), 0);
    });
  });

  group('measureTuiCell', () {
    testWidgets('returns the same size for the same style and scale', (
      tester,
    ) async {
      late Size first;
      late Size second;
      await pumpApp(
        tester,
        home: Builder(
          builder: (context) {
            first = measureTuiCell(context);
            second = measureTuiCell(context);
            return const SizedBox();
          },
        ),
      );

      expect(first, second);
      expect(first.width, greaterThan(0));
      expect(first.height, greaterThan(0));
    });

    testWidgets('grows with the text scale', (tester) async {
      Future<Size> sizeAt(double scale) async {
        late Size size;
        await pumpApp(
          tester,
          textScale: scale,
          home: Builder(
            builder: (context) {
              size = measureTuiCell(context);
              return const SizedBox();
            },
          ),
        );
        return size;
      }

      final normal = await sizeAt(1);
      final large = await sizeAt(2);

      expect(large.height, greaterThan(normal.height));
      expect(large.width, greaterThan(normal.width));
    });
  });

  group('painters', () {
    Future<CustomPainter?> painterOfBar(
      WidgetTester tester,
      double fraction, {
      Color? color,
    }) async {
      await pumpApp(
        tester,
        home: Scaffold(
          body: TuiBar(fraction: fraction, color: color),
        ),
      );
      return _painterOf(tester, TuiBar);
    }

    testWidgets('a bar repaints only when something it draws changes', (
      tester,
    ) async {
      final half = await painterOfBar(tester, 0.5);
      final halfAgain = await painterOfBar(tester, 0.5);
      final more = await painterOfBar(tester, 0.75);
      final colored = await painterOfBar(
        tester,
        0.5,
        color: const Color(0xFF123456),
      );

      expect(halfAgain!.shouldRepaint(half!), isFalse);
      expect(more!.shouldRepaint(half), isTrue);
      expect(colored!.shouldRepaint(half), isTrue);
    });

    testWidgets('a bar sits in its own repaint boundary', (tester) async {
      await painterOfBar(tester, 1);

      expect(
        find.descendant(
          of: find.byType(TuiBar),
          matching: find.byType(RepaintBoundary),
        ),
        findsWidgets,
      );
    });

    testWidgets('a bar draws at every fill without error', (tester) async {
      for (final fraction in [0.0, 0.01, 0.5, 1.0]) {
        await painterOfBar(tester, fraction);
        expect(tester.takeException(), isNull, reason: '$fraction');
      }
    });

    Future<CustomPainter?> painterOfShade(
      WidgetTester tester,
      int level, {
      Color? color,
    }) async {
      await pumpApp(
        tester,
        home: Scaffold(
          body: SizedBox(
            width: 60,
            height: 14,
            child: TuiShade(level: level, color: color),
          ),
        ),
      );
      return _painterOf(tester, TuiShade);
    }

    testWidgets('a shade repaints when its level or color changes', (
      tester,
    ) async {
      final one = await painterOfShade(tester, 1);
      final oneAgain = await painterOfShade(tester, 1);
      final two = await painterOfShade(tester, 2);
      final red = await painterOfShade(tester, 1, color: Colors.red);

      expect(oneAgain!.shouldRepaint(one!), isFalse);
      expect(two!.shouldRepaint(one), isTrue);
      expect(red!.shouldRepaint(one), isTrue);
    });

    testWidgets('a shade draws every level without error', (tester) async {
      for (final level in [0, 1, 2, 3, 4, 7]) {
        await painterOfShade(tester, level);
        expect(tester.takeException(), isNull, reason: 'level $level');
      }
    });

    testWidgets('a dashed line repaints when its color changes', (
      tester,
    ) async {
      Future<CustomPainter?> painterWith(Color? color) async {
        await pumpApp(
          tester,
          home: Scaffold(body: TuiDashedLine(color: color)),
        );
        return _painterOf(tester, TuiDashedLine);
      }

      final plain = await painterWith(null);
      final plainAgain = await painterWith(null);
      final red = await painterWith(Colors.red);

      expect(plainAgain!.shouldRepaint(plain!), isFalse);
      expect(red!.shouldRepaint(plain), isTrue);
    });

    testWidgets('tree guides repaint only when the lines change', (
      tester,
    ) async {
      Future<CustomPainter?> painterWith(List<TreeGuide> guides) async {
        await pumpApp(
          tester,
          home: Scaffold(
            body: AccountRow(
              name: 'Food',
              amount: thb(100),
              guides: guides,
              hasChildren: false,
              isExpanded: false,
              onToggle: () {},
            ),
          ),
        );
        return tester
            .widgetList<CustomPaint>(find.byType(CustomPaint))
            .map((paint) => paint.painter)
            .whereType<CustomPainter>()
            .first;
      }

      final tee = await painterWith([TreeGuide.pipe, TreeGuide.tee]);
      final sameLines = await painterWith([TreeGuide.pipe, TreeGuide.tee]);
      final elbow = await painterWith([TreeGuide.pipe, TreeGuide.elbow]);
      final blank = await painterWith([TreeGuide.blank, TreeGuide.elbow]);

      expect(sameLines!.shouldRepaint(tee!), isFalse);
      expect(elbow!.shouldRepaint(tee), isTrue);
      expect(blank!.shouldRepaint(elbow), isTrue);
    });
  });
}
