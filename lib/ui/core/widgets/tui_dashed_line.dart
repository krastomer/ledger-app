import 'package:flutter/material.dart';

class TuiDashedLine extends StatelessWidget {
  const TuiDashedLine({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      width: double.infinity,
      child: CustomPaint(
        painter: _DashPainter(
          color ?? Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
    );
  }
}

class _DashPainter extends CustomPainter {
  const _DashPainter(this.color);

  static const _dash = 3.0;
  static const _gap = 3.0;

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    for (var x = 0.0; x < size.width; x += _dash + _gap) {
      canvas.drawRect(Rect.fromLTWH(x, 0, _dash, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(_DashPainter old) => old.color != color;
}
