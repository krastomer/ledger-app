import 'dart:convert';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/services/ledger_file_service.dart';
import 'package:ledger_app/utils/result.dart';

void main() {
  test('asks only for JSON files', () async {
    List<XTypeGroup>? asked;
    final service = LedgerFileService(
      opener: (types) async {
        asked = types;
        return null;
      },
    );

    await service.pick();

    expect(asked?.single.extensions, ['json']);
    expect(asked?.single.mimeTypes, ['application/json']);
  });

  test('asks for the types it is given', () async {
    List<XTypeGroup>? asked;
    final service = LedgerFileService(
      opener: (types) async {
        asked = types;
        return null;
      },
    );

    await service.pick(types: const [LedgerFileService.rulesType]);

    expect(asked?.single.extensions, ['rules', 'txt']);
    expect(asked?.single.mimeTypes, ['*/*']);
  });

  test('is ok with nothing when the user backs out', () async {
    final service = LedgerFileService(opener: (_) async => null);

    final result = await service.pick();

    expect((result as Ok<LedgerFile?>).value, isNull);
  });

  test('reads the name, size and text of the chosen file', () async {
    const text = '[{"note":"สวัสดี"}]';
    final bytes = utf8.encode(text);
    final service = LedgerFileService(
      opener: (_) async =>
          XFile.fromData(bytes, name: 'export.json', path: '/tmp/export.json'),
    );

    final result = await service.pick();

    final file = (result as Ok<LedgerFile?>).value;
    expect(file?.name, 'export.json');
    expect(file?.sizeBytes, bytes.length);
    expect(file?.text, text);
  });

  test('returns an error when the file cannot be opened', () async {
    final service = LedgerFileService(
      opener: (_) async => throw Exception('no access'),
    );

    expect(await service.pick(), isA<Error<LedgerFile?>>());
  });
}
