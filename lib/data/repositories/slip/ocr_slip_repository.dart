import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/data/parsers/slip/slip_parser.dart';
import 'package:ledger_app/data/services/slip_image_service.dart';
import 'package:ledger_app/data/services/slip_ocr_service.dart';
import 'package:ledger_app/utils/result.dart';

import 'slip_repository.dart';

class UnknownSlipException implements Exception {
  const UnknownSlipException();
}

class OcrSlipRepository implements SlipRepository {
  OcrSlipRepository({
    required this._ocr,
    required this._images,
    this._parser = const SlipParser(),
  });

  final SlipOcrService _ocr;
  final SlipImageService _images;
  final SlipParser _parser;

  @override
  Future<Result<List<String>>> pickImages() => _images.pickImages();

  @override
  Future<Result<ParsedSlip>> read(String imagePath) async {
    switch (await _ocr.recognize(imagePath)) {
      case Ok(:final value):
        // Picked images are copies with new names, so the original
        // filename (often the reference) isn't passed on.
        final parsed = _parser.parse(value);
        return parsed == null
            ? const Result.error(UnknownSlipException())
            : Result.ok(parsed);
      case Error(:final error):
        return Result.error(error);
    }
  }
}
