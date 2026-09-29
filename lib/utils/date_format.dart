import 'package:intl/intl.dart';
import 'package:ledger_app/domain/models/year_era.dart';

/// "Tue, Sep 29, 2026" in English; "อ. 29 ก.ย. 2569" in Thai. intl gives
/// neither the Buddhist Era year nor the usual abbreviated Thai weekday (its
/// short weekdays are full names), so the year is appended here.
String formatLongDate(DateTime date, String locale, YearEra era) {
  final year = era.yearOf(date);
  if (locale.startsWith('th')) {
    final dayMonth = DateFormat('EEEEE. d MMM', locale).format(date);
    return '$dayMonth $year';
  }
  return '${DateFormat.MMMEd(locale).format(date)}, $year';
}

String formatMonthName(DateTime date, String locale) =>
    DateFormat.MMMM(locale).format(date);
