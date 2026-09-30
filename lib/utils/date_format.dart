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

String formatMonthYear(DateTime date, String locale, YearEra era) =>
    '${formatMonthName(date, locale)} ${era.yearOf(date)}';

String formatDayHeading(DateTime date, String locale) => locale.startsWith('th')
    ? DateFormat('EEEEE. d MMM', locale).format(date)
    : DateFormat.MMMEd(locale).format(date);

String formatTime(Duration time) {
  final hours = time.inHours.toString().padLeft(2, '0');
  final minutes = (time.inMinutes % 60).toString().padLeft(2, '0');
  return '$hours:$minutes';
}
