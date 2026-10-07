import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

import 'ledger_book.dart';

part 'daily_spend.freezed.dart';

@freezed
abstract class DailySpend with _$DailySpend {
  const factory DailySpend({
    required DateTime month,

    /// Expenses booked on each day; index 0 is the 1st of [month].
    required List<Money> days,

    /// Days counted towards [average]: up to today in the current month,
    /// the whole month otherwise.
    required int elapsedDays,

    /// Today's day of the month when [month] is the current month.
    int? today,
    required Money average,

    /// The day with the most spending, if any day had some.
    int? peakDay,

    /// Name of the category that took the largest part of [peakDay].
    String? peakCategory,
  }) = _DailySpend;

  const DailySpend._();

  /// Upper bounds of shade levels 1 to 3; anything above is level 4.
  static final levelLimits = [
    for (final baht in [300, 600, 1200])
      Money.fromInt(baht * 100, isoCode: LedgerBook.currency),
  ];

  /// 0 for a day without spending, then 1 to 4 by [levelLimits].
  static int levelOf(Money amount) => amount.isPositive
      ? 1 + levelLimits.where((limit) => amount >= limit).length
      : 0;

  Money? get peakAmount => switch (peakDay) {
    final day? => days[day - 1],
    null => null,
  };

  bool isFuture(int day) {
    final today = this.today;
    return today != null && day > today;
  }
}
