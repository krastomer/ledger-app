import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/widgets/tui_cell.dart';

/// Fills the space it gets with `░` `▒` `▓` `█` shading for [level] 1 to 4,
/// or a `·····` row for 0. Painted for the same reason as `TuiBar`.
class TuiShade extends StatelessWidget {
  const TuiShade({super.key, required this.level, this.color});

  final int level;

  /// Defaults to the text color, or the faint line color for level 0.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ExcludeSemantics(
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _ShadePainter(
            level: level,
            cellWidth: measureTuiCell(context).width,
            color:
                color ?? (level > 0 ? scheme.onSurface : scheme.outlineVariant),
          ),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _ShadePainter extends CustomPainter {
  const _ShadePainter({
    required this.level,
    required this.cellWidth,
    required this.color,
  });

  static const _dot = 2.0;

  final int level;
  final double cellWidth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..isAntiAlias = false;
    if (level >= 4) {
      canvas.drawRect(Offset.zero & size, paint);
      return;
    }
    if (level <= 0) {
      if (cellWidth <= 0) return;
      final top = ((size.height - _dot) / 2).roundToDouble();
      for (var x = cellWidth / 2; x < size.width; x += cellWidth) {
        canvas.drawRect(
          Rect.fromLTWH((x - _dot / 2).roundToDouble(), top, _dot, _dot),
          paint,
        );
      }
      return;
    }
    // A 2×2 tile with one, two or three pixels lit: 25%, 50%, 75%.
    final points = [
      for (var y = 0; y < size.height.floor(); y++)
        for (var x = 0; x < size.width.floor(); x++)
          if (_isLit(x.isOdd, y.isOdd)) Offset(x + 0.5, y + 0.5),
    ];
    canvas.drawPoints(ui.PointMode.points, points, paint..strokeWidth = 1);
  }

  bool _isLit(bool oddX, bool oddY) => switch (level) {
    1 => !oddX && !oddY,
    2 => oddX == oddY,
    _ => oddX || oddY,
  };

  @override
  bool shouldRepaint(_ShadePainter old) =>
      old.level != level || old.cellWidth != cellWidth || old.color != color;
}
