import 'package:freezed_annotation/freezed_annotation.dart';

import 'posting.dart';
import 'transaction_status.dart';

part 'ledger_transaction.freezed.dart';

@freezed
abstract class LedgerTransaction with _$LedgerTransaction {
  const factory LedgerTransaction({
    required String id,

    /// Calendar date in the user's time zone (time part is zero). Kept out
    /// of UTC so a transaction at 01:00 doesn't move to the previous day.
    required DateTime date,

    /// Time of day, when known (e.g. read from a slip).
    Duration? time,
    required String description,
    @Default(TransactionStatus.unmarked) TransactionStatus status,

    /// Slip reference number; hledger's transaction code.
    String? code,
    required List<Posting> postings,
  }) = _LedgerTransaction;

  const LedgerTransaction._();

  /// Whether the postings sum to zero in every currency.
  bool get isBalanced {
    final totals = <String, BigInt>{};
    for (final p in postings) {
      final code = p.amount.currency.isoCode;
      totals[code] = (totals[code] ?? BigInt.zero) + p.amount.minorUnits;
    }
    return totals.values.every((total) => total == BigInt.zero);
  }
}
