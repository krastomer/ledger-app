import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/posting.dart';

import '../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  LedgerTransaction entry(List<Posting> postings) => LedgerTransaction(
    id: '1',
    date: DateTime(2026, 9, 29),
    description: 'Lunch',
    postings: postings,
  );

  test('balances when postings sum to zero', () {
    expect(
      entry([
        Posting(account: 'Expenses:Food', amount: thb(6000)),
        Posting(account: 'Assets:Cash', amount: thb(-6000)),
      ]).isBalanced,
      isTrue,
    );
  });

  test('does not balance when postings are off by a satang', () {
    expect(
      entry([
        Posting(account: 'Expenses:Food', amount: thb(6000)),
        Posting(account: 'Assets:Cash', amount: thb(-5999)),
      ]).isBalanced,
      isFalse,
    );
  });
}
