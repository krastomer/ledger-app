import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/year_era.dart';

void main() {
  final date = DateTime(2026, 9, 29);

  test('Buddhist Era is 543 years after the Gregorian year', () {
    expect(YearEra.buddhist.yearOf(date), 2569);
  });

  test('Gregorian keeps the calendar year', () {
    expect(YearEra.gregorian.yearOf(date), 2026);
  });
}
