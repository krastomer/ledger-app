import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/utils/money_format.dart';
import 'package:money2/money2.dart';

void main() {
  Money thb(int satang) => Money.fromInt(satang, isoCode: 'THB');

  test('formats with the baht symbol and grouping', () {
    expect(formatMoney(thb(123456)), '฿1,234.56');
  });

  test('uses a minus sign for negative amounts', () {
    expect(formatMoney(thb(-6000)), '−฿60.00');
  });

  test('adds a plus sign only when asked', () {
    expect(formatMoney(thb(4500000), showPlus: true), '+฿45,000.00');
    expect(formatMoney(thb(0), showPlus: true), '฿0.00');
  });

  test('can omit the symbol', () {
    expect(formatMoney(thb(123456), showSymbol: false), '1,234.56');
  });

  test('shortens whole amounts for scales', () {
    expect(formatCompactMoney(thb(30000)), '300');
    expect(formatCompactMoney(thb(120000)), '1.2k');
    expect(formatCompactMoney(thb(1500099)), '15k');
  });
}
