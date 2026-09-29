// Writes the expected parse result for each OCR fixture in a directory, as
// `{ "<image filename>": "<describeParsedSlip>" }`. The slip parity
// integration test checks each platform's OCR + parser against it.
//
//   dart run tool/expected_slips.dart testing/fixtures/slips_private out.json
import 'dart:convert';
import 'dart:io';

import 'package:ledger_app/data/parsers/slip/slip_parser.dart';

import '../testing/fixtures/slip_fixtures.dart';
import '../testing/slip_parity.dart';

void main(List<String> args) {
  if (args.length != 2) {
    stderr.writeln('usage: expected_slips.dart <fixture-dir> <out.json>');
    exit(2);
  }
  const parser = SlipParser();
  final files =
      Directory(args[0])
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.json'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  final expected = <String, String>{
    for (final file in files)
      for (final fixture in [SlipFixture.fromFile(file)])
        fixture.fileName: describeParsedSlip(
          parser.parse(fixture.lines, fileName: fixture.fileName),
        ),
  };
  File(args[1])
      .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(expected));
  stdout.writeln('wrote ${expected.length} expectations to ${args[1]}');
}
