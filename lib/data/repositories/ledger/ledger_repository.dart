import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/utils/result.dart';

abstract interface class LedgerRepository {
  Future<Result<List<Account>>> getAccounts();

  Future<Result<List<LedgerTransaction>>> getTransactions();

  /// Adds [transaction], or replaces the one with the same id. Fails when
  /// its postings don't balance.
  Future<Result<void>> save(LedgerTransaction transaction);

  Future<Result<void>> delete(String id);

  /// Starts over with [accounts] and [transactions], dropping what was there.
  Future<Result<void>> replaceAll({
    required List<Account> accounts,
    required List<LedgerTransaction> transactions,
  });

  /// Fires after every [save] and [delete], so screens can reload.
  Stream<void> get changes;
}
