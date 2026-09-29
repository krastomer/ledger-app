import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/category_total.dart';
import 'package:ledger_app/domain/models/home_summary.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/posting.dart';
import 'package:ledger_app/domain/models/transaction_kind.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/domain/models/transaction_summary.dart';
import 'package:ledger_app/utils/result.dart';
import 'package:money2/money2.dart';

class HomeSummaryUseCase {
  HomeSummaryUseCase({
    required this._ledgerRepository,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  static const currency = 'THB';
  static const topSpendingCount = 3;
  static const recentCount = 5;

  final LedgerRepository _ledgerRepository;
  final DateTime Function() _now;

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
  _Ledger(List<Account> accounts, this.transactions)
    : _types = {for (final account in accounts) account.name: account.type};

  final List<LedgerTransaction> transactions;
  final Map<String, AccountType> _types;

  static final _zero = Money.fromInt(0, isoCode: HomeSummaryUseCase.currency);

  HomeSummary summarize(DateTime now) {
    bool inMonth(LedgerTransaction t) =>
        t.date.year == now.year && t.date.month == now.month;
    final monthTransactions = transactions.where(inMonth).toList();

    final assets = _sum(transactions, AccountType.asset);
    final liabilities = -_sum(transactions, AccountType.liability);
    final monthIncome = -_sum(monthTransactions, AccountType.income);
    final monthExpenses = _sum(monthTransactions, AccountType.expense);

    return HomeSummary(
      asOf: now,
      netWorth: assets - liabilities,
      assets: assets,
      liabilities: liabilities,
      monthIncome: monthIncome,
      monthExpenses: monthExpenses,
      monthNet: monthIncome - monthExpenses,
      topSpending: _topSpending(monthTransactions, monthExpenses),
      recent: _newestFirst()
          .take(HomeSummaryUseCase.recentCount)
          .map(_summarizeTransaction)
          .toList(),
      pendingCount: transactions
          .where((t) => t.status == TransactionStatus.pending)
          .length,
    );
  }

  Iterable<Posting> _postings(
    Iterable<LedgerTransaction> from,
    AccountType type,
  ) => [
    for (final t in from)
      for (final p in t.postings)
        if (_isCounted(p) && _types[p.rootAccount] == type) p,
  ];

  bool _isCounted(Posting p) =>
      p.amount.currency.isoCode == HomeSummaryUseCase.currency;

  Money _sum(Iterable<LedgerTransaction> from, AccountType type) =>
      _total(_postings(from, type));

  Money _total(Iterable<Posting> postings) =>
      postings.fold(_zero, (total, p) => total + p.amount);

  List<CategoryTotal> _topSpending(
    List<LedgerTransaction> monthTransactions,
    Money monthExpenses,
  ) {
    final byCategory = <String, Money>{};
    for (final p in _postings(monthTransactions, AccountType.expense)) {
      final category = p.account
          .split(accountSeparator)
          .take(2)
          .join(accountSeparator);
      byCategory[category] = (byCategory[category] ?? _zero) + p.amount;
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

  /// Newest date first. Within a day, timed entries come before untimed
  /// ones, and ties fall back to entry order (later entries first).
  Iterable<LedgerTransaction> _newestFirst() {
    final indexed = transactions.indexed.toList()
      ..sort((a, b) {
        final (aIndex, aTx) = a;
        final (bIndex, bTx) = b;
        final byDate = bTx.date.compareTo(aTx.date);
        if (byDate != 0) return byDate;
        final byTime = switch ((aTx.time, bTx.time)) {
          (final aTime?, final bTime?) => bTime.compareTo(aTime),
          (null, null) => 0,
          (null, _) => 1,
          (_, null) => -1,
        };
        return byTime != 0 ? byTime : bIndex.compareTo(aIndex);
      });
    return indexed.map((entry) => entry.$2);
  }

  TransactionSummary _summarizeTransaction(LedgerTransaction t) {
    final expenses = _postings([t], AccountType.expense);
    final income = _postings([t], AccountType.income);
    final (kind, amount) = expenses.isNotEmpty
        ? (TransactionKind.expense, _total(expenses))
        : income.isNotEmpty
        ? (TransactionKind.income, -_total(income))
        : (
            TransactionKind.transfer,
            _total(
              t.postings.where((p) => _isCounted(p) && p.amount.isPositive),
            ),
          );
    return TransactionSummary(
      id: t.id,
      description: t.description,
      date: t.date,
      time: t.time,
      from:
          t.postings.where((p) => p.amount.isNegative).firstOrNull?.leafName ??
          '',
      to:
          t.postings.where((p) => p.amount.isPositive).firstOrNull?.leafName ??
          '',
      amount: amount,
      kind: kind,
      isPending: t.status == TransactionStatus.pending,
      hasSlip: t.code != null,
    );
  }
}
