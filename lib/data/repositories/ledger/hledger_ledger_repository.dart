import 'package:ledger_app/data/parsers/hledger/hledger_json_parser.dart';
import 'package:ledger_app/data/parsers/hledger/parsed_ledger.dart';
import 'package:ledger_app/data/services/ledger_asset_service.dart';
import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/utils/result.dart';

import 'ledger_repository.dart';

class LedgerImportException implements Exception {
  const LedgerImportException(this.issues);

  final List<LedgerIssue> issues;

  @override
  String toString() => 'LedgerImportException(${issues.length} issues)';
}

/// Loads an `hledger print -O json` export once and serves it from memory.
class HledgerLedgerRepository implements LedgerRepository {
  HledgerLedgerRepository({
    required this._source,
    this._parser = const HledgerJsonParser(),
  });

  final LedgerAssetService _source;
  final HledgerJsonParser _parser;
  Future<Result<ParsedLedger>>? _ledger;

  @override
  Future<Result<List<Account>>> getAccounts() async => switch (await _load()) {
    Ok(:final value) => Result.ok(value.accounts),
    Error(:final error) => Result.error(error),
  };

  @override
  Future<Result<List<LedgerTransaction>>> getTransactions() async =>
      switch (await _load()) {
        Ok(:final value) => Result.ok(value.transactions),
        Error(:final error) => Result.error(error),
      };

  Future<Result<ParsedLedger>> _load() async {
    final result = await (_ledger ??= _readAndParse());
    if (result is Error) _ledger = null;
    return result;
  }

  Future<Result<ParsedLedger>> _readAndParse() async {
    switch (await _source.read()) {
      case Ok(:final value):
        final ledger = _parser.parse(value);
        return ledger.issues.isEmpty
            ? Result.ok(ledger)
            : Result.error(LedgerImportException(ledger.issues));
      case Error(:final error):
        return Result.error(error);
    }
  }
}
