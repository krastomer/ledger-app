import 'package:flutter/services.dart';

import 'package:ledger_app/utils/result.dart';

import 'ocr_line.dart';

/// On-device OCR of slip images, implemented natively per platform.
///
/// Channel contract (`ledger_app/slip_ocr`):
/// - method `recognize`, argument: image file path (`String`)
/// - returns `List<Map>`, one per text line, top to bottom as the OCR
///   engine orders them, with keys `text` (`String`), `confidence`,
///   `x`, `y`, `width`, `height` (all `double`, box normalized to 0..1,
///   origin top-left)
/// - errors: `bad_args`, `ocr_failed`
///
/// iOS: Apple Vision (`ios/Runner/AppDelegate.swift`). Android: Tesseract
/// with Thai + English models (`android/.../SlipOcrPlugin.kt`), which
/// upscales, binarizes and splits lines into label/value segments so its
/// output matches Vision's closely enough for the shared parser;
/// `tool/slip_parity.sh` checks both give the same parse results.
class SlipOcrService {
  static const _channel = MethodChannel('ledger_app/slip_ocr');

  Future<Result<List<OcrLine>>> recognize(String imagePath) async {
    try {
      final lines = await _channel.invokeListMethod<Object?>(
        'recognize',
        imagePath,
      );
      return Result.ok([
        for (final line in lines ?? const <Object?>[])
          switch (line) {
            final Map<Object?, Object?> map => OcrLine.fromMap(map),
            _ => throw const FormatException('Unexpected OCR line'),
          },
      ]);
    } on MissingPluginException {
      return Result.error(
        Exception('Slip OCR is not available on this platform yet'),
      );
    } on PlatformException catch (e) {
      return Result.error(Exception('Slip OCR failed (${e.code})'));
    } on FormatException {
      return Result.error(Exception('Slip OCR returned unexpected data'));
    }
  }
}
