import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

import 'transaction_day.dart';

part 'month_transactions.freezed.dart';

@freezed
abstract class MonthTransactions with _$MonthTransactions {
  const factory MonthTransactions({
    required DateTime month,
    required DateTime earliestMonth,
    required DateTime latestMonth,

    /// Totals cover the whole month, whatever filters [days] went through.
    required Money income,
    required Money expenses,
    required Money net,
    required List<TransactionDay> days,
  }) = _MonthTransactions;

  const MonthTransactions._();

  bool get isEarliestMonth => !month.isAfter(earliestMonth);

  bool get isLatestMonth => !month.isBefore(latestMonth);

  bool get isEmpty => days.isEmpty;
}
