import 'package:flutter/widgets.dart';

final _measured = <(TextStyle, TextScaler), Size>{};

/// The size of one character cell in the ambient text style.
Size measureTuiCell(BuildContext context) {
  final style = DefaultTextStyle.of(context).style;
  final scaler = MediaQuery.textScalerOf(context);
  final cached = _measured[(style, scaler)];
  if (cached != null) return cached;
  final painter = TextPainter(
    text: TextSpan(text: '█', style: style),
    textScaler: scaler,
    textDirection: TextDirection.ltr,
    maxLines: 1,
  )..layout();
  final size = painter.size;
  painter.dispose();
  if (_measured.length >= 16) _measured.clear();
  return _measured[(style, scaler)] = size;
}
