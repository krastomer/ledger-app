import 'dart:math' as math;

import 'package:flutter/material.dart';

class DonutSlice {
  const DonutSlice({
    required this.weight,
    required this.color,
    required this.textColor,
    required this.name,
    required this.value,
  });

  final double weight;
  final Color color;
  final Color textColor;
  final String name;
  final String value;
}

const _holeRatio = 0.52;
const _twoPi = 2 * math.pi;

bool donutHoleAt(Offset point, Size size) {
  final outer = math.min(size.width, size.height) / 2;
  return (point - size.center(Offset.zero)).distance < outer * _holeRatio;
}

int? donutSliceAt(Offset point, Size size, List<double> weights) {
  final center = size.center(Offset.zero);
  final outer = math.min(size.width, size.height) / 2;
  final delta = point - center;
  final distance = delta.distance;
  if (distance > outer || distance < outer * _holeRatio) return null;
  final angle = (math.atan2(delta.dx, -delta.dy) + _twoPi) % _twoPi;
  final total = weights.fold(0.0, (sum, w) => sum + w);
  if (total <= 0) return null;
  var end = 0.0;
  for (final (index, weight) in weights.indexed) {
    end += weight / total * _twoPi;
    if (angle < end) return index;
  }
  return weights.isEmpty ? null : weights.length - 1;
}

class DonutChart extends StatefulWidget {
  const DonutChart({
    super.key,
    required this.slices,
    required this.center,
    required this.onSliceTap,
    this.onCenterTap,
    this.height = 240,
  });

  final List<DonutSlice> slices;
  final Widget center;
  final ValueChanged<int> onSliceTap;
  final VoidCallback? onCenterTap;
  final double height;

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final Animation<double> _progress = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  List<DonutSlice> get slices => widget.slices;

  @override
  void initState() {
    super.initState();
    _controller.value = 1;
  }

  @override
  void didUpdateWidget(DonutChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_sameSlices(oldWidget.slices, widget.slices) &&
        !MediaQuery.disableAnimationsOf(context)) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _sameSlices(List<DonutSlice> a, List<DonutSlice> b) =>
      a.length == b.length &&
      [
        for (var i = 0; i < a.length; i++)
          a[i].weight == b[i].weight &&
              a[i].color == b[i].color &&
              a[i].name == b[i].name,
      ].every((same) => same);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = widget.height;
    final onSliceTap = widget.onSliceTap;
    final onCenterTap = widget.onCenterTap;
    final center = widget.center;
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, height);
          final diameter = math.min(size.width, size.height) - 4;
          final weights = [for (final s in slices) s.weight];
          return Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapUp: (details) {
                  final index = donutSliceAt(
                    details.localPosition,
                    size,
                    weights,
                  );
                  if (index != null) {
                    onSliceTap(index);
                  } else if (donutHoleAt(details.localPosition, size)) {
                    onCenterTap?.call();
                  }
                },
                child: CustomPaint(
                  size: size,
                  painter: _DonutPainter(
                    progress: _progress,
                    slices: slices,
                    separator: theme.colorScheme.surface,
                    style: theme.textTheme.labelSmall ?? const TextStyle(),
                  ),
                ),
              ),
              IgnorePointer(
                child: SizedBox(
                  width: diameter * _holeRatio,
                  height: diameter * _holeRatio,
                  child: Center(child: center),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  _DonutPainter({
    required this.progress,
    required this.slices,
    required this.separator,
    required this.style,
  }) : super(repaint: progress);

  final Animation<double> progress;
  final List<DonutSlice> slices;
  final Color separator;
  final TextStyle style;

  @override
  void paint(Canvas canvas, Size size) {
    final total = slices.fold(0.0, (sum, s) => sum + s.weight);
    if (total <= 0) return;
    final center = size.center(Offset.zero);
    final outer = math.min(size.width, size.height) / 2 - 2;
    final inner = outer * _holeRatio;
    final middle = (outer + inner) / 2;
    final revealed = progress.value * _twoPi;
    final labelOpacity = ((progress.value - 0.6) / 0.4).clamp(0.0, 1.0);
    var offset = 0.0;
    for (final slice in slices) {
      final fullSweep = slice.weight / total * _twoPi;
      final start = -math.pi / 2 + offset;
      final sweep = math.min(fullSweep, math.max(0.0, revealed - offset));
      offset += fullSweep;
      if (sweep <= 0) continue;
      final path = _segment(center, outer, inner, start, sweep);
      canvas.drawPath(path, Paint()..color = slice.color);
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..strokeJoin = StrokeJoin.round
          ..color = separator,
      );
      final share = slice.weight / total;
      if (share >= 0.06 && labelOpacity > 0) {
        final mid = start + fullSweep / 2;
        _paintLabel(
          canvas,
          center + Offset(math.cos(mid), math.sin(mid)) * middle,
          slice,
          withName: share >= 0.12,
          maxWidth: (outer - inner) * 1.4,
          opacity: labelOpacity,
        );
      }
    }
  }

  Path _segment(
    Offset center,
    double outer,
    double inner,
    double start,
    double sweep,
  ) {
    final outerRect = Rect.fromCircle(center: center, radius: outer);
    final innerRect = Rect.fromCircle(center: center, radius: inner);
    if (sweep >= _twoPi - 1e-6) {
      return Path()
        ..fillType = PathFillType.evenOdd
        ..addOval(outerRect)
        ..addOval(innerRect);
    }
    return Path()
      ..arcTo(outerRect, start, sweep, true)
      ..arcTo(innerRect, start + sweep, -sweep, false)
      ..close();
  }

  void _paintLabel(
    Canvas canvas,
    Offset at,
    DonutSlice slice, {
    required bool withName,
    required double maxWidth,
    required double opacity,
  }) {
    final textColor = slice.textColor.withValues(alpha: opacity);
    final painters = [
      if (withName)
        TextPainter(
          text: TextSpan(
            text: slice.name,
            style: style.copyWith(color: textColor),
          ),
          maxLines: 1,
          ellipsis: '…',
          textDirection: TextDirection.ltr,
        ),
      TextPainter(
        text: TextSpan(
          text: slice.value,
          style: style.copyWith(color: textColor, fontWeight: FontWeight.w600),
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      ),
    ];
    for (final painter in painters) {
      painter.layout(maxWidth: maxWidth);
    }
    final height = painters.fold(0.0, (sum, p) => sum + p.height);
    var y = at.dy - height / 2;
    for (final painter in painters) {
      painter.paint(canvas, Offset(at.dx - painter.width / 2, y));
      y += painter.height;
      painter.dispose();
    }
  }

  @override
  bool shouldRepaint(_DonutPainter old) =>
      old.slices != slices || old.separator != separator || old.style != style;
}
