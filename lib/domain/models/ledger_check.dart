import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_check.freezed.dart';

/// What the app found when it opened the ledger.
@freezed
abstract class LedgerCheck with _$LedgerCheck {
  const factory LedgerCheck({
    required int transactionCount,
    DateTime? firstMonth,
    DateTime? lastMonth,
    required int unbalancedCount,
    required int reviewCount,
  }) = _LedgerCheck;
}
