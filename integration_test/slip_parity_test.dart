// Runs the real platform OCR (Vision on iOS, Tesseract on Android) plus the
// shared parser over sample slip images, and checks every platform gets the
// same result.
//
// Needs, via --dart-define:
//   SLIP_DIR  directory on the device with the images and `expected.json`
//             (from tool/expected_slips.dart)
//   SLIP_OUT  optional directory to write each image's raw OCR lines and
//             the parse results (`results.json`) to, for comparing platforms
//
// See tool/slip_parity.sh for pushing the files and running it.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ledger_app/data/parsers/slip/slip_parser.dart';
import 'package:ledger_app/data/services/ocr_line.dart';
import 'package:ledger_app/data/services/slip_ocr_service.dart';
import 'package:ledger_app/utils/result.dart';

import '../testing/slip_parity.dart';

const _slipDir = String.fromEnvironment('SLIP_DIR');
const _outDir = String.fromEnvironment('SLIP_OUT');

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final dir = Directory(_slipDir);
  final expected = _slipDir.isEmpty
      ? const <String, Object?>{}
      : jsonDecode(File('$_slipDir/expected.json').readAsStringSync())
            as Map<String, Object?>;

  test('SLIP_DIR has sample images', () {
    expect(_slipDir, isNotEmpty, reason: 'pass --dart-define=SLIP_DIR=...');
    expect(expected, isNotEmpty);
  });

  final ocr = SlipOcrService();
  const parser = SlipParser();
  final results = <String, String>{};

  tearDownAll(() {
    if (_outDir.isEmpty) return;
    Directory(_outDir).createSync(recursive: true);
    File('$_outDir/results.json')
        .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(results));
  });

  for (final name in expected.keys.toList()..sort()) {
    test('parses $name like the other platforms', () async {
      final result = await ocr.recognize('${dir.path}/$name');
      final lines = switch (result) {
        Ok(:final value) => value,
        Error(:final error) => fail('OCR failed: $error'),
      };
      if (_outDir.isNotEmpty) {
        _dump(name, lines);
      }

      final parsed = parser.parse(lines, fileName: name);
      results[name] = describeParsedSlip(parsed);

      expect(results[name], expected[name]);
    }, timeout: const Timeout(Duration(minutes: 2)));
  }
}

void _dump(String name, List<OcrLine> lines) {
  Directory(_outDir).createSync(recursive: true);
  final stem = name.substring(0, name.lastIndexOf('.'));
  File('$_outDir/$stem.json').writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert({
      'file': name,
      'lines': [
        for (final line in lines)
          {
            'text': line.text,
            'confidence': line.confidence,
            'x': line.x,
            'y': line.y,
            'width': line.width,
            'height': line.height,
          },
      ],
    }),
  );
}
