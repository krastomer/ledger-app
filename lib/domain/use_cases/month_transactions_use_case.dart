import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/ledger_book.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/month_transactions.dart';
import 'package:ledger_app/domain/models/transaction_day.dart';
import 'package:ledger_app/domain/models/transaction_filter.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/utils/result.dart';

class MonthTransactionsUseCase {
  MonthTransactionsUseCase({
    required this._ledgerRepository,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final LedgerRepository _ledgerRepository;
  final DateTime Function() _now;

  Future<Result<MonthTransactions>> call({
    DateTime? month,
    TransactionFilter filter = const TransactionFilter(),
  }) async {
    final accounts = await _ledgerRepository.getAccounts();
    final transactions = await _ledgerRepository.getTransactions();
    final now = _now();
    final today = DateTime(now.year, now.month, now.day);
    final requested = month ?? today;
    return switch ((accounts, transactions)) {
      (Ok(value: final accounts), Ok(value: final transactions)) => Result.ok(
        _list(
          LedgerBook(accounts: accounts, transactions: transactions),
          DateTime(requested.year, requested.month),
          today,
          filter,
        ),
      ),
      (Error(:final error), _) ||
      (_, Error(:final error)) => Result.error(error),
    };
  }

  MonthTransactions _list(
    LedgerBook book,
    DateTime month,
    DateTime today,
    TransactionFilter filter,
  ) {
    final monthTransactions = book.inMonth(month);
    final income = -book.sum(monthTransactions, AccountType.income);
    final expenses = book.sum(monthTransactions, AccountType.expense);
    final matching = monthTransactions.where(
      (t) => _matches(t, _terms(filter.query), filter),
    );
    return MonthTransactions(
      month: month,
      earliestMonth: book.earliestMonth ?? DateTime(today.year, today.month),
      latestMonth: DateTime(today.year, today.month),
      income: income,
      expenses: expenses,
      net: income - expenses,
      days: _byDay(book, matching, today),
    );
  }

  List<TransactionDay> _byDay(
    LedgerBook book,
    Iterable<LedgerTransaction> transactions,
    DateTime today,
  ) {
    final days = <TransactionDay>[];
    for (final t in book.newestFirst(transactions)) {
      final summary = book.summarize(t);
      if (days.isNotEmpty && days.last.date == t.date) {
        final last = days.removeLast();
        days.add(last.copyWith(transactions: [...last.transactions, summary]));
      } else {
        days.add(
          TransactionDay(
            date: t.date,
            isToday: t.date == today,
            transactions: [summary],
          ),
        );
      }
    }
    return days;
  }

  List<String> _terms(String query) => query
      .toLowerCase()
      .split(RegExp(r'\s+'))
      .where((term) => term.isNotEmpty)
      .toList();

  bool _matches(
    LedgerTransaction t,
    List<String> terms,
    TransactionFilter filter,
  ) {
    if (filter.pendingOnly && t.status != TransactionStatus.pending) {
      return false;
    }
    if (filter.withSlipOnly && t.code == null) return false;
    if (terms.isEmpty) return true;
    final haystack = [
      t.description,
      ?t.code,
      for (final p in t.postings) p.account,
    ].join('\n').toLowerCase();
    return terms.every(haystack.contains);
  }
}
