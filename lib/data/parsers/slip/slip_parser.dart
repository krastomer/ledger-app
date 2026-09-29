import 'package:ledger_app/data/services/ocr_line.dart';

import 'dime_order_layout.dart';
import 'kkp_slip_layout.dart';
import 'kplus_slip_layout.dart';
import 'parsed_slip.dart';
import 'scb_slip_layout.dart';
import 'slip_layout.dart';
import 'slip_page.dart';

/// Turns OCR lines of a slip image into a [ParsedSlip].
///
/// Works on the geometry-normalized [OcrLine]s every platform's OCR
/// returns, so the same parser serves iOS (Vision) and Android.
class SlipParser {
  const SlipParser({
    this.layouts = const [
      KplusSlipLayout(),
      ScbSlipLayout(),
      KkpSlipLayout(),
      DimeOrderLayout(),
    ],
  });

  final List<SlipLayout> layouts;

  /// Returns null when no known layout matches. [fileName] is the image's
  /// original filename, if known; some apps name it after the reference.
  ParsedSlip? parse(List<OcrLine> lines, {String? fileName}) {
    final page = SlipPage(lines);
    for (final layout in layouts) {
      if (layout.matches(page)) {
        return layout.parse(page, fileStem: _stem(fileName));
      }
    }
    return null;
  }

  static String? _stem(String? fileName) {
    if (fileName == null) return null;
    final base = fileName.split('/').last;
    final dot = base.lastIndexOf('.');
    return dot > 0 ? base.substring(0, dot) : base;
  }
}
