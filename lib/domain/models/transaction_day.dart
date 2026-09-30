import 'package:freezed_annotation/freezed_annotation.dart';

import 'transaction_summary.dart';

part 'transaction_day.freezed.dart';

@freezed
abstract class TransactionDay with _$TransactionDay {
  const factory TransactionDay({
    required DateTime date,
    required bool isToday,
    required List<TransactionSummary> transactions,
  }) = _TransactionDay;
}
