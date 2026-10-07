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

String formatDate(DateTime date, String locale, YearEra era) {
  final year = era.yearOf(date);
  return locale.startsWith('th')
      ? '${DateFormat('d MMM', locale).format(date)} $year'
      : '${DateFormat.MMMd(locale).format(date)}, $year';
}

String formatMonthShort(DateTime date, String locale) =>
    DateFormat.MMM(locale).format(date);

String formatMonthShortYear(DateTime date, String locale, YearEra era) =>
    '${formatMonthShort(date, locale)} ${era.yearOf(date)}';

String formatMonthDay(DateTime date) => DateFormat('MM-dd').format(date);

/// Monday first: "Mo" … "Su" in English, "จ" … "อา" in Thai.
List<String> formatWeekdayInitials(String locale) {
  final isThai = locale.startsWith('th');
  final format = isThai ? DateFormat('EEEEE', locale) : DateFormat.E(locale);
  return [
    for (var day = 1; day <= DateTime.daysPerWeek; day++)
      switch (format.format(DateTime(2024, 1, day))) {
        final name when isThai => name,
        final name => name.substring(0, 2),
      },
  ];
}

/// `2026-09-29`, as the journal and the terminal screens write dates.
String formatIsoDate(DateTime date) => DateFormat('yyyy-MM-dd').format(date);

/// `2026-09`.
String formatIsoMonth(DateTime date) => DateFormat('yyyy-MM').format(date);

/// `tue` in English, `อ.` in Thai.
String formatWeekdayShort(DateTime date, String locale) =>
    locale.startsWith('th')
    ? DateFormat('EEEEE.', locale).format(date)
    : DateFormat.E(locale).format(date).toLowerCase();
