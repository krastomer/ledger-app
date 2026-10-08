import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/money.dart';

void main() {
  group('Money.tryParse', () {
    test('reads thousands separators and two decimals into satang', () {
      expect(Money.tryParse('12,345.67'), const Money(1234567));
    });

    test('pads a single decimal', () {
      expect(Money.tryParse('1,234.5'), const Money(123450));
    });

    test('accepts whole numbers', () {
      expect(Money.tryParse('150'), const Money(15000));
    });

    test('keeps the sign of negative amounts', () {
      expect(Money.tryParse('-7.64'), const Money(-764));
    });

    test('keeps the currency', () {
      expect(
        Money.tryParse('209.47', currency: 'USD'),
        const Money(20947, currency: 'USD'),
      );
    });

    test('rejects more than two decimals', () {
      expect(Money.tryParse('0.7295008'), isNull);
    });

    test('rejects misplaced separators', () {
      expect(Money.tryParse('1,23.00'), isNull);
    });

    test('rejects text', () {
      expect(Money.tryParse('THB'), isNull);
    });
  });

  test('adds amounts of the same currency', () {
    expect(const Money(764) + const Money(-764), const Money(0));
  });

  test('prints in a plain debug form', () {
    expect(const Money(-764).toString(), '-7.64 THB');
  });

  group('Money', () {
    test('adds amounts of the same currency', () {
      expect(const Money(150) + const Money(-50), const Money(100));
    });

    test('is equal by amount and currency, with a matching hash', () {
      expect(const Money(100), const Money(100));
      expect(const Money(100).hashCode, const Money(100).hashCode);
      expect(const Money(100), isNot(const Money(100, currency: 'USD')));
      expect(const Money(100), isNot(const Money(101)));
    });

    test('prints a plain amount with its currency', () {
      expect(const Money(12550).toString(), '125.50 THB');
      expect(const Money(-5).toString(), '-0.05 THB');
      expect(const Money(0, currency: 'USD').toString(), '0.00 USD');
    });
  });

  group('Money currencies', () {
    test('refuses to add amounts of different currencies', () {
      expect(
        () => const Money(100) + const Money(100, currency: 'USD'),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
