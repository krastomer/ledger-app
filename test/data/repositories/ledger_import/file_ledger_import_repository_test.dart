import 'dart:convert';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/repositories/ledger/hledger_ledger_repository.dart';
import 'package:ledger_app/data/repositories/ledger_import/file_ledger_import_repository.dart';
import 'package:ledger_app/data/services/ledger_file_service.dart';
import 'package:ledger_app/domain/models/ledger_import_draft.dart';
import 'package:ledger_app/utils/result.dart';

class _FakeLedgerFiles implements LedgerFileService {
  _FakeLedgerFiles(this.result);

  Result<LedgerFile?> result;

  @override
  Future<Result<LedgerFile?>> pick({
    List<XTypeGroup> types = const [LedgerFileService.jsonType],
  }) async => result;
}

void main() {
  Map<String, Object?> posting(String account, int satang) => {
    'paccount': account,
    'ptype': 'RegularPosting',
    'pamount': [
      {
        'acommodity': 'THB',
        'acost': null,
        'aquantity': {'decimalMantissa': satang, 'decimalPlaces': 2},
      },
    ],
  };
  Map<String, Object?> entry(String date, int satang) => {
    'tindex': 1,
    'tdate': date,
    'tstatus': 'Cleared',
    'tcode': '',
    'tdescription': 'Lunch',
    'ttags': <Object?>[],
    'tpostings': [
      posting('Expenses:Food', satang),
      posting('Assets:Cash', -satang),
    ],
  };

  FileLedgerImportRepository build(Result<LedgerFile?> result) =>
      FileLedgerImportRepository(files: _FakeLedgerFiles(result));

  LedgerFile file(Object? json) =>
      LedgerFile(name: 'ledger.json', sizeBytes: 100, text: jsonEncode(json));

  test('summarises the export that was read', () async {
    final repository = build(
      Result.ok(file([entry('2026-09-02', 6000), entry('2026-09-01', 4500)])),
    );

    final draft = switch (await repository.pickFile()) {
      Ok(:final value) => value,
      Error(:final error) => throw error,
    };

    expect(draft?.fileName, 'ledger.json');
    expect(draft?.transactionCount, 2);
    expect(draft?.accountCount, 2);
    expect(draft?.unbalancedCount, 0);
    expect(draft?.firstDate, DateTime(2026, 9, 1));
    expect(draft?.lastDate, DateTime(2026, 9, 2));
  });

  test('returns null when the user backs out', () async {
    final result = await build(const Result.ok(null)).pickFile();

    expect((result as Ok<LedgerImportDraft?>).value, isNull);
  });

  test('fails with the unreadable entries when the export is bad', () async {
    final result = await build(Result.ok(file({'not': 'a list'}))).pickFile();

    expect(
      (result as Error<LedgerImportDraft?>).error,
      isA<LedgerImportException>().having((e) => e.issues.length, 'issues', 1),
    );
  });

  test('passes on a failure to open the file', () async {
    final result = await build(Result.error(Exception('io'))).pickFile();

    expect(result, isA<Error<LedgerImportDraft?>>());
  });
}
