import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

import 'transaction_kind.dart';

part 'transaction_summary.freezed.dart';

@freezed
abstract class TransactionSummary with _$TransactionSummary {
  const factory TransactionSummary({
    required String id,
    required String description,
    required DateTime date,
    Duration? time,
    required String from,
    required String to,

    /// Always positive; [kind] says which way the money went.
    required Money amount,
    required TransactionKind kind,
    required bool isPending,
    required bool hasSlip,
  }) = _TransactionSummary;
}
