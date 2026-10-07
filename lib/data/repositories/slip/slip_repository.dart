import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/utils/result.dart';

abstract interface class SlipRepository {
  /// Asks the user for slip images; empty when they cancel.
  Future<Result<List<String>>> pickImages();

  /// Reads a slip image on the device. Fails when OCR fails or the image
  /// isn't a slip layout the app knows.
  Future<Result<ParsedSlip>> read(String imagePath);
}
