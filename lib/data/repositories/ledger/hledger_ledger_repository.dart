import 'dart:async';

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

class UnbalancedTransactionException implements Exception {
  const UnbalancedTransactionException();
}

/// Loads an `hledger print -O json` export once and serves it from memory.
///
// TODO(kasama): edits only last until the app closes; move them to the
// SQLite repository with soft deletes and a change log (sync.md).
class HledgerLedgerRepository implements LedgerRepository {
  HledgerLedgerRepository({
    required this._source,
    this._parser = const HledgerJsonParser(),
  });

  final LedgerAssetService _source;
  final HledgerJsonParser _parser;
  Future<Result<ParsedLedger>>? _ledger;
  final _saved = <String, LedgerTransaction>{};
  final _deleted = <String>{};
  final _changes = StreamController<void>.broadcast();

  @override
  Stream<void> get changes => _changes.stream;

  @override
  Future<Result<List<Account>>> getAccounts() async => switch (await _load()) {
    Ok(:final value) => Result.ok(value.accounts),
    Error(:final error) => Result.error(error),
  };

  @override
  Future<Result<List<LedgerTransaction>>> getTransactions() async =>
      switch (await _load()) {
        Ok(:final value) => Result.ok(_withEdits(value.transactions)),
        Error(:final error) => Result.error(error),
      };

  @override
  Future<Result<void>> save(LedgerTransaction transaction) async {
    if (!transaction.isBalanced) {
      return const Result.error(UnbalancedTransactionException());
    }
    _saved[transaction.id] = transaction;
    _deleted.remove(transaction.id);
    _changes.add(null);
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> delete(String id) async {
    _deleted.add(id);
    _changes.add(null);
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> replaceAll({
    required List<Account> accounts,
    required List<LedgerTransaction> transactions,
  }) async {
    _saved.clear();
    _deleted.clear();
    _ledger = Future.value(
      Result.ok(
        ParsedLedger(
          accounts: accounts,
          transactions: transactions,
          issues: const [],
        ),
      ),
    );
    _changes.add(null);
    return const Result.ok(null);
  }

  List<LedgerTransaction> _withEdits(List<LedgerTransaction> imported) {
    final ids = {for (final t in imported) t.id};
    return [
      for (final t in imported)
        if (!_deleted.contains(t.id)) _saved[t.id] ?? t,
      for (final t in _saved.values)
        if (!ids.contains(t.id) && !_deleted.contains(t.id)) t,
    ];
  }

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
