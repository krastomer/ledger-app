import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

import 'category_total.dart';
import 'transaction_summary.dart';

part 'home_summary.freezed.dart';

@freezed
abstract class HomeSummary with _$HomeSummary {
  const factory HomeSummary({
    required DateTime asOf,
    required Money netWorth,
    required Money assets,
    required Money liabilities,
    required Money monthIncome,
    required Money monthExpenses,
    required Money monthNet,
    required List<CategoryTotal> topSpending,
    required List<TransactionSummary> recent,
    required int pendingCount,
  }) = _HomeSummary;
}
