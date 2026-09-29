import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/repositories/ledger/hledger_ledger_repository.dart';
import 'package:ledger_app/data/services/ledger_asset_service.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/utils/result.dart';

class _FakeLedgerSource implements LedgerAssetService {
  _FakeLedgerSource(this.result);

  Result<String> result;
  var reads = 0;

  @override
  Future<Result<String>> read() async {
    reads++;
    return result;
  }
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
  final export = jsonEncode([
    {
      'tindex': 1,
      'tdate': '2026-09-01',
      'tstatus': 'Cleared',
      'tcode': '',
      'tdescription': 'Lunch',
      'ttags': <Object?>[],
      'tpostings': [
        posting('Expenses:Food', 6000),
        posting('Assets:Cash', -6000),
      ],
    },
  ]);

  test('returns accounts and transactions from the export', () async {
    final repository = HledgerLedgerRepository(
      source: _FakeLedgerSource(Result.ok(export)),
    );

    final transactions = await repository.getTransactions();
    final accounts = await repository.getAccounts();

    expect(
      (transactions as Ok<List<LedgerTransaction>>).value.single.description,
      'Lunch',
    );
    expect(accounts, isA<Ok>());
  });

  test('reads the source only once', () async {
    final source = _FakeLedgerSource(Result.ok(export));
    final repository = HledgerLedgerRepository(source: source);

    await repository.getAccounts();
    await repository.getTransactions();

    expect(source.reads, 1);
  });

  test('returns an import error when the export has issues', () async {
    final repository = HledgerLedgerRepository(
      source: _FakeLedgerSource(const Result.ok('garbage')),
    );

    final result = await repository.getTransactions();

    expect(
      result,
      isA<Error<List<LedgerTransaction>>>().having(
        (e) => e.error,
        'error',
        isA<LedgerImportException>(),
      ),
    );
  });

  test('retries after a failed read', () async {
    final source = _FakeLedgerSource(Result.error(Exception('missing')));
    final repository = HledgerLedgerRepository(source: source);

    expect(await repository.getTransactions(), isA<Error>());
    source.result = Result.ok(export);

    expect(await repository.getTransactions(), isA<Ok>());
  });
}
