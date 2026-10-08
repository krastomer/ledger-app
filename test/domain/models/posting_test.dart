import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/posting.dart';

import '../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  Posting posting(String account) => Posting(account: account, amount: thb(1));

  test('splits a deep account into root, category and leaf', () {
    final p = posting('Expenses:Food:Lunch:Office');

    expect(p.rootAccount, 'Expenses');
    expect(p.category, 'Expenses:Food');
    expect(p.leafName, 'Office');
  });

  test('a two-level account is its own category', () {
    final p = posting('Expenses:Food');

    expect(p.rootAccount, 'Expenses');
    expect(p.category, 'Expenses:Food');
    expect(p.leafName, 'Food');
  });

  test('a root-only account is root, category and leaf at once', () {
    final p = posting('Assets');

    expect(p.rootAccount, 'Assets');
    expect(p.category, 'Assets');
    expect(p.leafName, 'Assets');
  });

  test('keeps empty segments as the split would', () {
    expect(posting('a::c').category, 'a:');
    expect(posting('a::c').leafName, 'c');
    expect(posting(':x').rootAccount, '');
    expect(posting('a:').leafName, '');
  });

  test('works with Thai account names', () {
    final p = posting('ค่าใช้จ่าย:อาหาร:ข้าวกลางวัน');

    expect(p.rootAccount, 'ค่าใช้จ่าย');
    expect(p.category, 'ค่าใช้จ่าย:อาหาร');
    expect(p.leafName, 'ข้าวกลางวัน');
  });
}
