import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

import 'account_node.dart';

part 'income_statement.freezed.dart';

@freezed
abstract class IncomeStatement with _$IncomeStatement {
  const factory IncomeStatement({
    required DateTime month,
    required DateTime earliestMonth,
    required DateTime latestMonth,
    required Money income,
    required Money expenses,
    required Money net,

    /// Net as a share of income in tenths of a percent; null unless the
    /// month has income and a surplus.
    int? savingsPerMille,

    /// Expenses as a share of income; null unless the month has income.
    int? expensesPerMille,
    required AccountNode expenseTree,
    required AccountNode incomeTree,
  }) = _IncomeStatement;

  const IncomeStatement._();

  bool get isEarliestMonth => !month.isAfter(earliestMonth);

  bool get isLatestMonth => !month.isBefore(latestMonth);

  bool get isEmpty => incomeTree.entryCount == 0 && expenseTree.entryCount == 0;
}
