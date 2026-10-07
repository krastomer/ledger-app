import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/account_node.dart';
import 'package:ledger_app/domain/models/account_tree_builder.dart';
import 'package:ledger_app/domain/models/daily_spend.dart';
import 'package:ledger_app/domain/models/income_statement.dart';
import 'package:ledger_app/domain/models/ledger_book.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/posting.dart';
import 'package:ledger_app/utils/result.dart';
import 'package:money2/money2.dart';

class IncomeStatementUseCase {
  IncomeStatementUseCase({
    required this._ledgerRepository,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final LedgerRepository _ledgerRepository;
  final DateTime Function() _now;

  /// Fires when the ledger changes, so screens can reload.
  Stream<void> get changes => _ledgerRepository.changes;

  Future<Result<IncomeStatement>> call({DateTime? month}) async {
    final accounts = await _ledgerRepository.getAccounts();
    final transactions = await _ledgerRepository.getTransactions();
    final now = _now();
    final latest = DateTime(now.year, now.month);
    final requested = month ?? latest;
    return switch ((accounts, transactions)) {
      (Ok(value: final accounts), Ok(value: final transactions)) => Result.ok(
        _statement(
          LedgerBook(accounts: accounts, transactions: transactions),
          DateTime(requested.year, requested.month),
          now,
        ),
      ),
      (Error(:final error), _) ||
      (_, Error(:final error)) => Result.error(error),
    };
  }

  IncomeStatement _statement(LedgerBook book, DateTime month, DateTime now) {
    final latest = DateTime(now.year, now.month);
    final monthTransactions = book.inMonth(month);
    final incomeTree = _tree(
      book.postings(monthTransactions, AccountType.income),
      negate: true,
    );
    final expenseTree = _tree(
      book.postings(monthTransactions, AccountType.expense),
    );
    final income = incomeTree.amount;
    final expenses = expenseTree.amount;
    final net = income - expenses;
    return IncomeStatement(
      month: month,
      earliestMonth: book.earliestMonth ?? latest,
      latestMonth: latest,
      income: income,
      expenses: expenses,
      net: net,
      savingsPerMille: income.isPositive && net.isPositive
          ? LedgerBook.perMille(net, income)
          : null,
      expensesPerMille: income.isPositive
          ? LedgerBook.perMille(expenses, income)
          : null,
      expenseTree: expenseTree,
      incomeTree: incomeTree,
      dailySpend: _dailySpend(book, monthTransactions, month, now),
    );
  }

  DailySpend _dailySpend(
    LedgerBook book,
    List<LedgerTransaction> monthTransactions,
    DateTime month,
    DateTime now,
  ) {
    final dayCount = DateTime(month.year, month.month + 1, 0).day;
    final days = List.filled(dayCount, LedgerBook.zero);
    final byCategory = [for (var i = 0; i < dayCount; i++) <String, Money>{}];
    for (final t in monthTransactions) {
      final index = t.date.day - 1;
      for (final p in book.postings([t], AccountType.expense)) {
        days[index] += p.amount;
        byCategory[index][p.category] =
            (byCategory[index][p.category] ?? LedgerBook.zero) + p.amount;
      }
    }
    final isCurrent = now.year == month.year && now.month == month.month;
    final elapsedDays = isCurrent ? now.day : dayCount;
    final spent = days
        .take(elapsedDays)
        .fold(LedgerBook.zero, (total, amount) => total + amount);
    int? peakIndex;
    for (final (index, amount) in days.indexed) {
      if (amount.isPositive &&
          (peakIndex == null || amount > days[peakIndex])) {
        peakIndex = index;
      }
    }
    final peakCategory = peakIndex == null
        ? null
        : byCategory[peakIndex].entries
              .reduce((a, b) => b.value > a.value ? b : a)
              .key
              .split(accountSeparator)
              .last;
    return DailySpend(
      month: month,
      days: days,
      elapsedDays: elapsedDays,
      today: isCurrent ? now.day : null,
      average: LedgerBook.divide(spent, elapsedDays),
      peakDay: peakIndex == null ? null : peakIndex + 1,
      peakCategory: peakCategory,
    );
  }

  AccountNode _tree(Iterable<Posting> postings, {bool negate = false}) {
    final builder = AccountTreeBuilder();
    for (final p in postings) {
      builder.add(p, negate: negate);
    }
    final root = builder.build();
    return root.children.length == 1 && root.ownEntryCount == 0
        ? root.children.single
        : root;
  }
}
