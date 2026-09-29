import 'parsed_slip.dart';
import 'slip_page.dart';

/// Parser for one app's slip layout.
abstract interface class SlipLayout {
  /// Whether [page] looks like this layout.
  bool matches(SlipPage page);

  /// Reads the slip. [fileStem] is the image filename without extension,
  /// which some apps set to the transaction reference.
  ParsedSlip parse(SlipPage page, {String? fileStem});
}
