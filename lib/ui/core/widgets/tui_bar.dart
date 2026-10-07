import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/widgets/tui_cell.dart';
import 'package:money2/money2.dart';

/// A `█████░░░` bar that fills the width it gets in steps of one character
/// cell. Painted rather than typed: the block glyphs leave seams between
/// cells on iOS.
class TuiBar extends StatelessWidget {
  const TuiBar({super.key, required this.fraction, this.color});

  /// 0 to 1; anything above zero shows at least one block.
  final double fraction;
  final Color? color;

  static double share(Money part, Money whole) => whole.isPositive
      ? (part.minorUnits.toDouble() / whole.minorUnits.toDouble()).clamp(0, 1)
      : 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final cell = measureTuiCell(context);
    return ExcludeSemantics(
      child: SizedBox(
        height: cell.height,
        width: double.infinity,
        child: CustomPaint(
          painter: _BarPainter(
            fraction: fraction,
            cellWidth: cell.width,
            fill: color ?? scheme.onSurface,
            track: scheme.outlineVariant,
          ),
        ),
      ),
    );
  }
}

class _BarPainter extends CustomPainter {
  const _BarPainter({
    required this.fraction,
    required this.cellWidth,
    required this.fill,
    required this.track,
  });

  final double fraction;
  final double cellWidth;
  final Color fill;
  final Color track;

  @override
  void paint(Canvas canvas, Size size) {
    if (cellWidth <= 0) return;
    final cells = (size.width / cellWidth).floor();
    if (cells == 0) return;
    final filled = fraction <= 0
        ? 0
        : (fraction * cells).round().clamp(1, cells);
    final blockHeight = (size.height * 0.7).roundToDouble();
    final top = ((size.height - blockHeight) / 2).roundToDouble();
    final split = filled * cellWidth;
    canvas.drawRect(
      Rect.fromLTWH(0, top, split, blockHeight),
      Paint()..color = fill,
    );
    final dots = [
      for (var y = top; y < top + blockHeight; y += 2)
        for (var x = split + 1; x < cells * cellWidth; x += 2)
          Offset(x + 0.5, y + 0.5),
    ];
    canvas.drawPoints(
      ui.PointMode.points,
      dots,
      Paint()
        ..color = track
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(_BarPainter old) =>
      old.fraction != fraction ||
      old.cellWidth != cellWidth ||
      old.fill != fill ||
      old.track != track;
}
