import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/utils/journal_format.dart';

import '../../testing/fixtures/ledger_fixtures.dart';

void main() {
  test('writes the entry as hledger journal text', () {
    final rent = fixtureTransaction(
      'Rent transfer',
      DateTime(2026, 9, 29),
      {'Expenses:Rent': thb(850000), 'Assets:Bank:KBank': thb(-850000)},
      time: const Duration(hours: 9, minutes: 15),
      status: TransactionStatus.pending,
      code: 'REF-4',
    );

    expect(
      formatJournalEntry(rent),
      '2026-09-29 ! (REF-4) Rent transfer  ; time:09:15\n'
      '    Expenses:Rent      THB 8,500.00\n'
      '    Assets:Bank:KBank',
    );
  });

  test('leaves out status and code when there are none', () {
    final lunch = fixtureTransaction('Lunch', DateTime(2026, 9, 1), {
      'Expenses:Food': thb(6000),
      'Assets:Cash': thb(-6000),
    }, status: TransactionStatus.unmarked);

    expect(formatJournalEntry(lunch).split('\n').first, '2026-09-01 Lunch');
  });
}
