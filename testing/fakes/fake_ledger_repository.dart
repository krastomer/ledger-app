import 'dart:async';

import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/utils/result.dart';

class FakeLedgerRepository implements LedgerRepository {
  FakeLedgerRepository({
    this.accounts = const [],
    List<LedgerTransaction> transactions = const [],
    this.error,
  }) : transactions = [...transactions];

  final List<Account> accounts;
  final List<LedgerTransaction> transactions;
  final Exception? error;
  final _changes = StreamController<void>.broadcast();

  @override
  Stream<void> get changes => _changes.stream;

  @override
  Future<Result<List<Account>>> getAccounts() async => switch (error) {
    final error? => Result.error(error),
    null => Result.ok(accounts),
  };

  @override
  Future<Result<List<LedgerTransaction>>> getTransactions() async =>
      switch (error) {
        final error? => Result.error(error),
        null => Result.ok([...transactions]),
      };

  @override
  Future<Result<void>> save(LedgerTransaction transaction) async {
    if (error case final error?) return Result.error(error);
    final index = transactions.indexWhere((t) => t.id == transaction.id);
    if (index < 0) {
      transactions.add(transaction);
    } else {
      transactions[index] = transaction;
    }
    _changes.add(null);
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> delete(String id) async {
    if (error case final error?) return Result.error(error);
    transactions.removeWhere((t) => t.id == id);
    _changes.add(null);
    return const Result.ok(null);
  }
}
