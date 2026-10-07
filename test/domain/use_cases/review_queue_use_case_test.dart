import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/review_item.dart';
import 'package:ledger_app/domain/use_cases/review_queue_use_case.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../testing/fakes/fake_ledger_repository.dart';
import '../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  Future<List<ReviewItem>> queueFor(List<LedgerTransaction> extra) async {
    final result = await ReviewQueueUseCase(
      ledgerRepository: FakeLedgerRepository(
        accounts: fixtureAccounts,
        transactions: [...fixtureTransactions, ...extra],
      ),
    )();
    return (result as Ok<List<ReviewItem>>).value;
  }

  test('lists pending entries', () async {
    final items = await queueFor(const []);

    expect(items.map((i) => (i.reason, i.transaction.id)), [
      (ReviewReason.pending, 'rent'),
    ]);
  });

  test('flags a later copy of an entry as a duplicate', () async {
    final copy = fixtureTransaction('bts again', DateTime(2026, 9, 28), {
      'Expenses:Transport': thb(5000),
      'Liabilities:Credit card': thb(-5000),
    });

    final items = await queueFor([copy]);

    expect(items.last.reason, ReviewReason.duplicate);
    expect(items.last.transaction.id, 'bts again');
    expect(items.last.duplicateOf, 'bts');
  });

  test(
    'offers categories of the same kind for uncategorized entries',
    () async {
      final unknown = fixtureTransaction('mystery', DateTime(2026, 9, 27), {
        'Expenses:Uncategorized': thb(1200),
        'Assets:Bank:KBank': thb(-1200),
      });

      final items = await queueFor([unknown]);
      final item = items.last;

      expect(item.reason, ReviewReason.uncategorized);
      expect(item.uncategorizedAccount, 'Expenses:Uncategorized');
      expect(item.categoryChoices, contains('Expenses:Rent'));
      expect(item.categoryChoices, isNot(contains('Expenses:Uncategorized')));
      expect(item.categoryChoices, isNot(contains('Income:Salary')));
    },
  );

  test('puts pending before duplicates before uncategorized', () async {
    final items = await queueFor([
      fixtureTransaction('mystery', DateTime(2026, 9, 29), {
        'Expenses:Unknown': thb(100),
        'Assets:Bank:KBank': thb(-100),
      }),
      fixtureTransaction('bts again', DateTime(2026, 9, 28), {
        'Expenses:Transport': thb(5000),
        'Liabilities:Credit card': thb(-5000),
      }),
    ]);

    expect(items.map((i) => i.reason), [
      ReviewReason.pending,
      ReviewReason.duplicate,
      ReviewReason.uncategorized,
    ]);
  });
}
