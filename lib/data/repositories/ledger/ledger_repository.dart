import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/utils/result.dart';

abstract interface class LedgerRepository {
  Future<Result<List<Account>>> getAccounts();

  Future<Result<List<LedgerTransaction>>> getTransactions();
}
