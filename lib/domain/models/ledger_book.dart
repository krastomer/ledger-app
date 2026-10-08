import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/posting.dart';
import 'package:ledger_app/domain/models/review_item.dart';
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

  /// [amount] split [parts] ways, rounded half up to the nearest satang.
  static Money divide(Money amount, int parts) => Money.fromBigInt(
    (amount.minorUnits * BigInt.two + BigInt.from(parts)) ~/
        BigInt.from(parts * 2),
    isoCode: amount.currency.isoCode,
  );

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
  Iterable<LedgerTransaction> newestFirst([
    Iterable<LedgerTransaction>? from,
  ]) => sortNewestFirst(from ?? transactions);

  /// [newestFirst] without a book. The entry order breaks every tie, so the
  /// result doesn't depend on the sort being stable.
  static List<LedgerTransaction> sortNewestFirst(
    Iterable<LedgerTransaction> from,
  ) {
    final indexed = from.toList().indexed.toList()
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
    return [for (final (_, transaction) in indexed) transaction];
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
      hasSlip: t.code != null || t.slipImagePath != null,
    );
  }

  /// Accounts of [type] that postings use, sorted.
  List<String> accountsOf(AccountType type) => ({
    for (final t in transactions)
      for (final p in t.postings)
        if (_types[p.rootAccount] == type) p.account,
  }.toList()..sort());

  /// Entries the user should look at, one item each: pending entries,
  /// later copies of an earlier entry (same day and postings), and entries
  /// booked to an uncategorized account. Newest first within each reason.
  List<ReviewItem> reviewItems() {
    final duplicateOf = _duplicates();
    final choices = <AccountType, List<String>>{};
    final byReason = [for (final _ in ReviewReason.values) <ReviewItem>[]];
    for (final t in newestFirst()) {
      final item = switch (_reasonOf(t, duplicateOf)) {
        ReviewReason.pending => ReviewItem(
          reason: ReviewReason.pending,
          transaction: summarize(t),
        ),
        ReviewReason.duplicate => ReviewItem(
          reason: ReviewReason.duplicate,
          transaction: summarize(t),
          duplicateOf: duplicateOf[t.id],
        ),
        ReviewReason.uncategorized => _uncategorizedItem(t, choices),
        null => null,
      };
      if (item != null) byReason[item.reason.index].add(item);
    }
    return [for (final items in byReason) ...items];
  }

  /// How many entries [reviewItems] lists, without building the items.
  int reviewCount() {
    final duplicateOf = _duplicates();
    return transactions.where((t) => _reasonOf(t, duplicateOf) != null).length;
  }

  ReviewReason? _reasonOf(
    LedgerTransaction t,
    Map<String, String> duplicateOf,
  ) {
    if (t.status == TransactionStatus.pending) return ReviewReason.pending;
    if (duplicateOf.containsKey(t.id)) return ReviewReason.duplicate;
    if (t.postings.any(_isUncategorized)) return ReviewReason.uncategorized;
    return null;
  }

  ReviewItem? _uncategorizedItem(
    LedgerTransaction t,
    Map<AccountType, List<String>> choices,
  ) {
    final posting = t.postings.where(_isUncategorized).firstOrNull;
    final type = posting == null ? null : _types[posting.rootAccount];
    if (posting == null || type == null) return null;
    return ReviewItem(
      reason: ReviewReason.uncategorized,
      transaction: summarize(t),
      uncategorizedAccount: posting.account,
      categoryChoices: choices.putIfAbsent(
        type,
        () => [
          for (final account in accountsOf(type))
            if (!_isUncategorizedName(account)) account,
        ],
      ),
    );
  }

  /// Transaction id → id of the earlier entry on the same day with the same
  /// postings.
  Map<String, String> _duplicates() {
    final firstByKey = <String, LedgerTransaction>{};
    final duplicateOf = <String, String>{};
    for (final t in transactions) {
      final key = _duplicateKey(t);
      final first = firstByKey[key];
      if (first == null) {
        firstByKey[key] = t;
      } else {
        duplicateOf[t.id] = first.id;
      }
    }
    return duplicateOf;
  }

  static String _duplicateKey(LedgerTransaction t) {
    final postings = [
      for (final p in t.postings)
        '${p.account}=${p.amount.minorUnits}${p.amount.currency.isoCode}',
    ]..sort();
    return '${t.date.toIso8601String()}|${postings.join('|')}';
  }

  bool _isUncategorized(Posting p) =>
      (_types[p.rootAccount] == AccountType.expense ||
          _types[p.rootAccount] == AccountType.income) &&
      _isUncategorizedName(p.account);

  static bool _isUncategorizedName(String account) => const {
    'uncategorized',
    'unknown',
  }.contains(account.split(accountSeparator).last.toLowerCase());

  bool _isCounted(Posting p) => p.amount.currency.isoCode == currency;
}
