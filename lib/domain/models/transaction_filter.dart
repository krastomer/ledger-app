import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_filter.freezed.dart';

@freezed
abstract class TransactionFilter with _$TransactionFilter {
  const factory TransactionFilter({
    @Default('') String query,
    @Default(false) bool pendingOnly,
    @Default(false) bool withSlipOnly,
  }) = _TransactionFilter;

  const TransactionFilter._();

  bool get isActive => query.trim().isNotEmpty || pendingOnly || withSlipOnly;
}
