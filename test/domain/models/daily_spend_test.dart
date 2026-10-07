import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/daily_spend.dart';

import '../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  test('shades a day by how much was spent', () {
    expect(DailySpend.levelOf(thb(0)), 0);
    expect(DailySpend.levelOf(thb(-5000)), 0);
    expect(DailySpend.levelOf(thb(1)), 1);
    expect(DailySpend.levelOf(thb(29999)), 1);
    expect(DailySpend.levelOf(thb(30000)), 2);
    expect(DailySpend.levelOf(thb(60000)), 3);
    expect(DailySpend.levelOf(thb(119999)), 3);
    expect(DailySpend.levelOf(thb(120000)), 4);
    expect(DailySpend.levelOf(thb(856000)), 4);
  });

  test('only counts days after today as the future', () {
    final current = DailySpend(
      month: DateTime(2026, 9),
      days: const [],
      elapsedDays: 29,
      today: 29,
      average: thb(0),
    );
    final past = current.copyWith(today: null, elapsedDays: 30);

    expect(current.isFuture(29), isFalse);
    expect(current.isFuture(30), isTrue);
    expect(past.isFuture(30), isFalse);
  });
}
