import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/posting.dart';
import 'package:ledger_app/domain/models/transaction_kind.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/domain/models/transaction_summary.dart';
import 'package:money2/money2.dart';

class LedgerBook {
  LedgerBook({required List<Account> accounts, required this.transactions})
    : _types = {for (final account in accounts) account.name: account.type};

  static const currency = 'THB';

  static final zero = Money.fromInt(0, isoCode: currency);

  static int perMille(Money part, Money whole) => whole.isPositive
      ? ((part.minorUnits * BigInt.from(2000) + whole.minorUnits) ~/
                (whole.minorUnits * BigInt.two))
            .toInt()
      : 0;

  final List<LedgerTransaction> transactions;
  final Map<String, AccountType> _types;

  DateTime? get earliestMonth {
    if (transactions.isEmpty) return null;
    final earliest = transactions
        .map((t) => t.date)
        .reduce((a, b) => a.isBefore(b) ? a : b);
    return DateTime(earliest.year, earliest.month);
  }

  List<LedgerTransaction> inMonth(DateTime month) => [
    for (final t in transactions)
      if (t.date.year == month.year && t.date.month == month.month) t,
  ];

  Iterable<Posting> postings(
    Iterable<LedgerTransaction> from,
    AccountType type,
  ) => [
    for (final t in from)
      for (final p in t.postings)
        if (_isCounted(p) && _types[p.rootAccount] == type) p,
  ];

  Money sum(Iterable<LedgerTransaction> from, AccountType type) =>
      total(postings(from, type));

  Money total(Iterable<Posting> postings) =>
      postings.fold(zero, (total, p) => total + p.amount);

  /// Newest date first. Within a day, timed entries come before untimed
  /// ones, and ties fall back to entry order (later entries first).
  Iterable<LedgerTransaction> newestFirst([Iterable<LedgerTransaction>? from]) {
    final indexed = (from ?? transactions).toList().indexed.toList()
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

  TransactionSummary summarize(LedgerTransaction t) {
    final expenses = postings([t], AccountType.expense);
    final income = postings([t], AccountType.income);
    final (kind, amount) = expenses.isNotEmpty
        ? (TransactionKind.expense, total(expenses))
        : income.isNotEmpty
        ? (TransactionKind.income, -total(income))
        : (
            TransactionKind.transfer,
            total(
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

  bool _isCounted(Posting p) => p.amount.currency.isoCode == currency;
}
