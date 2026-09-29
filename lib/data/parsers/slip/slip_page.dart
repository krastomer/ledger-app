import 'package:ledger_app/data/services/ocr_line.dart';

import 'slip_text.dart';

/// The OCR lines of one slip image, with lookups by text and position.
///
/// OCR engines don't return two-column layouts in reading order, so values
/// are found next to their labels by geometry rather than by line order.
class SlipPage {
  SlipPage(Iterable<OcrLine> lines)
    : lines = [
        for (final line in lines)
          OcrLine(
            text: SlipText.normalize(line.text),
            confidence: line.confidence,
            x: line.x,
            y: line.y,
            width: line.width,
            height: line.height,
          ),
      ]..sort((a, b) => a.y.compareTo(b.y));

  /// All lines, top to bottom, with [SlipText.normalize]d text.
  final List<OcrLine> lines;

  /// First line whose text matches [text], or starts with it when [prefix]
  /// is true. Compared by [SlipText.skeleton], so dropped vowels, marks,
  /// dots and spaces don't matter; labels of 6+ skeleton characters also
  /// match with one character added, dropped or changed.
  OcrLine? label(String text, {bool prefix = false}) {
    final wanted = SlipText.skeleton(text);
    bool matches(String t, {required bool fuzzy}) {
      if (prefix) return t.startsWith(wanted);
      if (!fuzzy) return t == wanted;
      return wanted.length >= 6 && _withinOneEdit(t, wanted);
    }

    for (final fuzzy in [false, true]) {
      for (final line in lines) {
        if (matches(SlipText.skeleton(line.text), fuzzy: fuzzy)) return line;
      }
    }
    return null;
  }

  /// First line (top to bottom) matching [pattern].
  OcrLine? find(RegExp pattern) {
    for (final line in lines) {
      if (pattern.hasMatch(line.text.trim())) return line;
    }
    return null;
  }

  bool contains(String text) => lines.any((l) => l.text.contains(text));

  /// The closest line to the right of [label] on the same row.
  OcrLine? rightOf(OcrLine label, {bool Function(OcrLine)? where}) {
    OcrLine? best;
    for (final line in lines) {
      if (identical(line, label) || line.x < label.right - 0.01) continue;
      if (!_sameRow(line, label)) continue;
      if (where != null && !where(line)) continue;
      if (best == null || line.x < best.x) best = line;
    }
    return best;
  }

  /// The nearest line starting below [anchor]'s top edge (within
  /// [maxGap]) that satisfies [where].
  OcrLine? below(
    OcrLine anchor, {
    bool Function(OcrLine)? where,
    double maxGap = 0.08,
  }) {
    for (final line in lines) {
      if (identical(line, anchor) || line.centerY <= anchor.bottom) continue;
      if (line.y - anchor.bottom > maxGap) break;
      if (where == null || where(line)) return line;
    }
    return null;
  }

  /// Lines whose vertical center lies in [top, bottom) and whose left edge
  /// lies in [left, right).
  List<OcrLine> within({
    double top = 0,
    double bottom = 1,
    double left = 0,
    double right = 1,
  }) => [
    for (final line in lines)
      if (line.centerY >= top &&
          line.centerY < bottom &&
          line.x >= left &&
          line.x < right)
        line,
  ];

  static bool _withinOneEdit(String a, String b) {
    if ((a.length - b.length).abs() > 1) return false;
    var i = 0;
    var j = 0;
    var edits = 0;
    while (i < a.length && j < b.length) {
      if (a[i] == b[j]) {
        i++;
        j++;
        continue;
      }
      if (++edits > 1) return false;
      if (a.length > b.length) {
        i++;
      } else if (a.length < b.length) {
        j++;
      } else {
        i++;
        j++;
      }
    }
    return edits + (a.length - i) + (b.length - j) <= 1;
  }

  static bool _sameRow(OcrLine a, OcrLine b) {
    final tolerance = 0.6 * (a.height > b.height ? a.height : b.height);
    return (a.centerY - b.centerY).abs() <= tolerance;
  }
}
