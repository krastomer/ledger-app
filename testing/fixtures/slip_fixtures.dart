import 'dart:convert';
import 'dart:io';

import 'package:ledger_app/data/services/ocr_line.dart';

/// OCR output of one slip image, as written by `tool/ocr_dump.swift`.
class SlipFixture {
  SlipFixture._(this.fileName, this.lines);

  /// Reads `testing/fixtures/<path>`.
  factory SlipFixture.load(String path) =>
      SlipFixture.fromFile(File('testing/fixtures/$path'));

  factory SlipFixture.fromFile(File file) {
    final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
    return SlipFixture._(json['file'] as String, [
      for (final line in json['lines'] as List<Object?>)
        OcrLine.fromMap(line as Map<Object?, Object?>),
    ]);
  }

  /// Original image filename.
  final String fileName;
  final List<OcrLine> lines;
}
