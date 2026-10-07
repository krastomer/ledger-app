import 'package:flutter/widgets.dart';

/// The size of one character cell in the ambient text style.
Size measureTuiCell(BuildContext context) {
  final painter = TextPainter(
    text: TextSpan(text: '█', style: DefaultTextStyle.of(context).style),
    textScaler: MediaQuery.textScalerOf(context),
    textDirection: TextDirection.ltr,
    maxLines: 1,
  )..layout();
  final size = painter.size;
  painter.dispose();
  return size;
}
