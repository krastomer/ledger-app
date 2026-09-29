import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/utils/result.dart';

class FakeLedgerRepository implements LedgerRepository {
  FakeLedgerRepository({
    this.accounts = const [],
    this.transactions = const [],
    this.error,
  });

  final List<Account> accounts;
  final List<LedgerTransaction> transactions;
  final Exception? error;

  @override
  Future<Result<List<Account>>> getAccounts() async => switch (error) {
    final error? => Result.error(error),
    null => Result.ok(accounts),
  };

  @override
  Future<Result<List<LedgerTransaction>>> getTransactions() async =>
      switch (error) {
        final error? => Result.error(error),
        null => Result.ok(transactions),
      };
}
