import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/utils/date_format.dart';

void main() {
  final date = DateTime(2026, 9, 29);

  setUpAll(() async {
    await initializeDateFormatting('th');
    await initializeDateFormatting('en');
  });

  test('shows the Buddhist Era year in Thai', () {
    expect(formatLongDate(date, 'th', YearEra.buddhist), 'อ. 29 ก.ย. 2569');
  });

  test('shows the Gregorian year in Thai', () {
    expect(formatLongDate(date, 'th', YearEra.gregorian), 'อ. 29 ก.ย. 2026');
  });

  test('shows the Gregorian year in English', () {
    expect(formatLongDate(date, 'en', YearEra.gregorian), 'Tue, Sep 29, 2026');
  });

  test('shows the Buddhist Era year in English', () {
    expect(formatLongDate(date, 'en', YearEra.buddhist), 'Tue, Sep 29, 2569');
  });

  test('formats month names per locale', () {
    expect(formatMonthName(date, 'th'), 'กันยายน');
    expect(formatMonthName(date, 'en'), 'September');
  });

  test('formats month and year with the chosen era', () {
    expect(formatMonthYear(date, 'th', YearEra.buddhist), 'กันยายน 2569');
    expect(formatMonthYear(date, 'en', YearEra.gregorian), 'September 2026');
  });

  test('formats a day heading without the year', () {
    expect(formatDayHeading(date, 'th'), 'อ. 29 ก.ย.');
    expect(formatDayHeading(date, 'en'), 'Tue, Sep 29');
  });

  test('formats a time of day with leading zeros', () {
    expect(formatTime(const Duration(hours: 9, minutes: 5)), '09:05');
    expect(formatTime(const Duration(hours: 18, minutes: 30)), '18:30');
  });

  test('formats a plain date in both languages', () {
    expect(formatDate(date, 'th', YearEra.buddhist), '29 ก.ย. 2569');
    expect(formatDate(date, 'en', YearEra.gregorian), 'Sep 29, 2026');
  });

  test('abbreviates the month', () {
    expect(formatMonthShort(date, 'th'), 'ก.ย.');
    expect(formatMonthShort(date, 'en'), 'Sep');
  });

  test('abbreviates the month with the chosen era', () {
    expect(formatMonthShortYear(date, 'th', YearEra.buddhist), 'ก.ย. 2569');
    expect(formatMonthShortYear(date, 'en', YearEra.gregorian), 'Sep 2026');
  });

  test('formats month and day as numbers', () {
    expect(formatMonthDay(date), '09-29');
  });
}
