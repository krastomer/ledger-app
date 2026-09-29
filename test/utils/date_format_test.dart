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
}
