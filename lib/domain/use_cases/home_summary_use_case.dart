import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/category_total.dart';
import 'package:ledger_app/domain/models/home_summary.dart';
import 'package:ledger_app/domain/models/ledger_book.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/posting.dart';
import 'package:ledger_app/utils/result.dart';
import 'package:money2/money2.dart';

class HomeSummaryUseCase {
  HomeSummaryUseCase({
    required this._ledgerRepository,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  static const topSpendingCount = 3;
  static const recentCount = 5;

  final LedgerRepository _ledgerRepository;
  final DateTime Function() _now;

  /// Fires when the ledger changes, so screens can reload.
  Stream<void> get changes => _ledgerRepository.changes;

  Future<Result<HomeSummary>> call() async {
    final accounts = await _ledgerRepository.getAccounts();
    final transactions = await _ledgerRepository.getTransactions();
    return switch ((accounts, transactions)) {
      (Ok(value: final accounts), Ok(value: final transactions)) => Result.ok(
        _Ledger(accounts, transactions).summarize(_now()),
      ),
      (Error(:final error), _) ||
      (_, Error(:final error)) => Result.error(error),
    };
  }
}

class _Ledger {
  _Ledger(List<Account> accounts, List<LedgerTransaction> transactions)
    : _book = LedgerBook(accounts: accounts, transactions: transactions);

  final LedgerBook _book;

  HomeSummary summarize(DateTime now) {
    final transactions = _book.transactions;
    final monthTransactions = _book.inMonth(now);

    final assets = _book.sum(transactions, AccountType.asset);
    final liabilities = -_book.sum(transactions, AccountType.liability);
    final monthIncome = -_book.sum(monthTransactions, AccountType.income);
    final monthExpenses = _book.sum(monthTransactions, AccountType.expense);

    return HomeSummary(
      asOf: now,
      netWorth: assets - liabilities,
      assets: assets,
      liabilities: liabilities,
      monthIncome: monthIncome,
      monthExpenses: monthExpenses,
      monthNet: monthIncome - monthExpenses,
      topSpending: _topSpending(monthTransactions, monthExpenses),
      recent: _book
          .newestFirst()
          .take(HomeSummaryUseCase.recentCount)
          .map(_book.summarize)
          .toList(),
      reviewCount: _book.reviewCount(),
    );
  }

  List<CategoryTotal> _topSpending(
    List<LedgerTransaction> monthTransactions,
    Money monthExpenses,
  ) {
    final byCategory = <String, Money>{};
    for (final p in _book.postings(monthTransactions, AccountType.expense)) {
      byCategory[p.category] =
          (byCategory[p.category] ?? LedgerBook.zero) + p.amount;
    }
    final sorted = byCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return [
      for (final MapEntry(key: account, value: amount) in sorted.take(
        HomeSummaryUseCase.topSpendingCount,
      ))
        CategoryTotal(
          account: account,
          name: account.split(accountSeparator).last,
          amount: amount,
          sharePerMille: _perMille(amount, monthExpenses),
        ),
    ];
  }

  int _perMille(Money part, Money whole) => whole.isZero
      ? 0
      : (part.minorUnits * BigInt.from(1000) ~/ whole.minorUnits).toInt();
}
