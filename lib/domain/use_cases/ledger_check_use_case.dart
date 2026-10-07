import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/domain/models/ledger_book.dart';
import 'package:ledger_app/domain/models/ledger_check.dart';
import 'package:ledger_app/utils/result.dart';

class LedgerCheckUseCase {
  LedgerCheckUseCase({required this._ledgerRepository});

  final LedgerRepository _ledgerRepository;

  Future<Result<LedgerCheck>> call() async {
    final accounts = await _ledgerRepository.getAccounts();
    final transactions = await _ledgerRepository.getTransactions();
    return switch ((accounts, transactions)) {
      (Ok(value: final accounts), Ok(value: final transactions)) => Result.ok(
        _check(LedgerBook(accounts: accounts, transactions: transactions)),
      ),
      (Error(:final error), _) ||
      (_, Error(:final error)) => Result.error(error),
    };
  }

  LedgerCheck _check(LedgerBook book) {
    final transactions = book.transactions;
    final dates = [for (final t in transactions) t.date]..sort();
    DateTime? monthOf(DateTime? date) =>
        date == null ? null : DateTime(date.year, date.month);
    return LedgerCheck(
      transactionCount: transactions.length,
      firstMonth: monthOf(dates.firstOrNull),
      lastMonth: monthOf(dates.lastOrNull),
      unbalancedCount: transactions.where((t) => !t.isBalanced).length,
      reviewCount: book.reviewItems().length,
    );
  }
}
