import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/domain/models/ledger_book.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/transaction_detail.dart';
import 'package:ledger_app/utils/result.dart';

class TransactionDetailUseCase {
  TransactionDetailUseCase({required this._ledgerRepository});

  final LedgerRepository _ledgerRepository;

  /// Null when no entry has [id], e.g. after it was deleted.
  Future<Result<TransactionDetail?>> call(String id) async {
    final accounts = await _ledgerRepository.getAccounts();
    final transactions = await _ledgerRepository.getTransactions();
    return switch ((accounts, transactions)) {
      (Ok(value: final accounts), Ok(value: final transactions)) => Result.ok(
        _detail(
          LedgerBook(accounts: accounts, transactions: transactions),
          transactions.where((t) => t.id == id).firstOrNull,
        ),
      ),
      (Error(:final error), _) ||
      (_, Error(:final error)) => Result.error(error),
    };
  }

  TransactionDetail? _detail(LedgerBook book, LedgerTransaction? transaction) =>
      transaction == null
      ? null
      : TransactionDetail(
          transaction: transaction,
          summary: book.summarize(transaction),
        );
}
