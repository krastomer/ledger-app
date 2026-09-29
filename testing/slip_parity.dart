import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';

/// A stable one-line summary of a parse result, used to compare what each
/// platform's OCR + the parser produce for the same slip image.
String describeParsedSlip(ParsedSlip? parsed) {
  if (parsed == null) return 'unrecognized';
  final missing = [for (final f in parsed.missing) f.name]..sort();
  return '${parsed.slip} missing: $missing';
}
