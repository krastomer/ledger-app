import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/ledger_import_draft.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/posting.dart';

import '../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  LedgerImportDraft draftOf(List<LedgerTransaction> transactions) =>
      LedgerImportDraft(
        fileName: 'ledger.json',
        sizeBytes: 100,
        accounts: fixtureAccounts,
        transactions: transactions,
      );

  test('counts entries, accounts used and unbalanced entries', () {
    final draft = draftOf([
      ...fixtureTransactions,
      fixtureTransaction('broken', DateTime(2026, 9), {
        'Expenses:Food': thb(100),
        'Assets:Bank:KBank': thb(-90),
      }),
    ]);

    expect(draft.transactionCount, fixtureTransactions.length + 1);
    expect(draft.unbalancedCount, 1);
    expect(draft.accountCount, 9);
  });

  test('knows the first and last date whatever the file order', () {
    final draft = draftOf([
      fixtureTransaction('mid', DateTime(2026, 5, 10), {
        'a': thb(1),
        'b': thb(-1),
      }),
      fixtureTransaction('last', DateTime(2026, 9, 29), {
        'a': thb(1),
        'b': thb(-1),
      }),
      fixtureTransaction('first', DateTime(2026, 1, 2), {
        'a': thb(1),
        'b': thb(-1),
      }),
    ]);

    expect(draft.firstDate, DateTime(2026, 1, 2));
    expect(draft.lastDate, DateTime(2026, 9, 29));
  });

  test('has no dates for an empty ledger', () {
    final draft = draftOf(const []);

    expect(draft.firstDate, isNull);
    expect(draft.lastDate, isNull);
    expect(draft.accountCount, 0);
  });

  test('a single entry is both first and last', () {
    final draft = draftOf([
      LedgerTransaction(
        id: 'one',
        date: DateTime(2026, 3, 3),
        description: 'one',
        postings: [Posting(account: 'a', amount: thb(0))],
      ),
    ]);

    expect(draft.firstDate, draft.lastDate);
  });
}
