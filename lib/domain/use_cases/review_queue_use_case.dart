import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/domain/models/ledger_book.dart';
import 'package:ledger_app/domain/models/review_item.dart';
import 'package:ledger_app/utils/result.dart';

class ReviewQueueUseCase {
  ReviewQueueUseCase({required this._ledgerRepository});

  final LedgerRepository _ledgerRepository;

  Stream<void> get changes => _ledgerRepository.changes;

  Future<Result<List<ReviewItem>>> call() async {
    final accounts = await _ledgerRepository.getAccounts();
    final transactions = await _ledgerRepository.getTransactions();
    return switch ((accounts, transactions)) {
      (Ok(value: final accounts), Ok(value: final transactions)) => Result.ok(
        LedgerBook(
          accounts: accounts,
          transactions: transactions,
        ).reviewItems(),
      ),
      (Error(:final error), _) ||
      (_, Error(:final error)) => Result.error(error),
    };
  }
}
