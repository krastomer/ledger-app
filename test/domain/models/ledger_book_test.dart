import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/ledger_book.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/review_item.dart';
import 'package:ledger_app/domain/models/transaction_kind.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';

import '../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  LedgerBook bookOf(List<LedgerTransaction> transactions) =>
      LedgerBook(accounts: fixtureAccounts, transactions: transactions);

  LedgerTransaction expense(
    String id,
    DateTime date, {
    String account = 'Expenses:Food',
    int satang = 1000,
    Duration? time,
    TransactionStatus status = TransactionStatus.cleared,
  }) => fixtureTransaction(
    id,
    date,
    {account: thb(satang), 'Assets:Bank:KBank': thb(-satang)},
    time: time,
    status: status,
  );

  group('reviewItems', () {
    test('keeps newest first within a reason in a long queue', () {
      final start = DateTime(2026, 1, 1);
      final book = bookOf([
        for (var day = 0; day < 120; day++)
          expense(
            'pending $day',
            start.add(Duration(days: day)),
            satang: 100 + day,
            status: TransactionStatus.pending,
          ),
        for (var day = 0; day < 120; day++)
          expense(
            'unknown $day',
            start.add(Duration(days: day)),
            account: 'Expenses:Uncategorized',
            satang: 5000 + day,
          ),
      ]);

      final items = book.reviewItems();

      expect(items, hasLength(240));
      expect(items.take(120).map((i) => i.transaction.id), [
        for (var day = 119; day >= 0; day--) 'pending $day',
      ]);
      expect(items.skip(120).map((i) => i.transaction.id), [
        for (var day = 119; day >= 0; day--) 'unknown $day',
      ]);
    });

    test('lists pending, then duplicates, then uncategorized', () {
      final day = DateTime(2026, 9, 1);
      final book = bookOf([
        expense('unknown', day, account: 'Expenses:Uncategorized', satang: 7),
        expense('first', day, satang: 900),
        expense('second', day, satang: 900),
        expense('waiting', day, satang: 300, status: TransactionStatus.pending),
      ]);

      final items = book.reviewItems();

      expect(items.map((i) => (i.reason, i.transaction.id)), [
        (ReviewReason.pending, 'waiting'),
        (ReviewReason.duplicate, 'second'),
        (ReviewReason.uncategorized, 'unknown'),
      ]);
    });

    test('offers every item of an account type the same choices', () {
      final day = DateTime(2026, 9, 1);
      final book = bookOf([
        expense('rent', day, account: 'Expenses:Rent', satang: 100),
        expense('a', day, account: 'Expenses:Uncategorized', satang: 1),
        expense('b', day, account: 'Expenses:Unknown', satang: 2),
      ]);

      final choices = book.reviewItems().map((i) => i.categoryChoices);

      expect(choices, hasLength(2));
      for (final list in choices) {
        expect(list, ['Expenses:Rent']);
      }
    });
  });

  group('summarize', () {
    test('describes an expense, an income and a transfer', () {
      final book = bookOf(fixtureTransactions);
      TransactionKind kindOf(String id) => book
          .summarize(fixtureTransactions.firstWhere((t) => t.id == id))
          .kind;

      expect(kindOf('lunch'), TransactionKind.expense);
      expect(kindOf('salary'), TransactionKind.income);
      expect(kindOf('to savings'), TransactionKind.transfer);
    });

    test('marks slips by code or by image', () {
      final book = bookOf(const []);
      final plain = expense('plain', DateTime(2026, 9, 1));

      expect(book.summarize(plain).hasSlip, isFalse);
      expect(book.summarize(plain.copyWith(code: 'REF')).hasSlip, isTrue);
      expect(
        book.summarize(plain.copyWith(slipImagePath: 'a.jpg')).hasSlip,
        isTrue,
      );
    });
  });

  group('newestFirst', () {
    test('orders by date, then time with untimed last, then entry order', () {
      final day = DateTime(2026, 9, 1);
      final book = bookOf([
        expense('untimed old', day, satang: 1),
        expense('noon', day, satang: 2, time: const Duration(hours: 12)),
        expense('evening', day, satang: 3, time: const Duration(hours: 18)),
        expense('untimed new', day, satang: 4),
        expense('next day', DateTime(2026, 9, 2), satang: 5),
      ]);

      expect(book.newestFirst().map((t) => t.id), [
        'next day',
        'evening',
        'noon',
        'untimed new',
        'untimed old',
      ]);
    });

    test('is deterministic for many entries on the same day', () {
      final day = DateTime(2026, 9, 1);
      final transactions = [
        for (var i = 0; i < 200; i++) expense('e$i', day, satang: i + 1),
      ];

      final ordered = bookOf(transactions).newestFirst().map((t) => t.id);

      expect(ordered, [for (var i = 199; i >= 0; i--) 'e$i']);
    });
  });

  group('amounts', () {
    test('perMille rounds half up and treats an empty whole as zero', () {
      expect(LedgerBook.perMille(thb(1), thb(3)), 333);
      expect(LedgerBook.perMille(thb(2), thb(3)), 667);
      expect(LedgerBook.perMille(thb(5), thb(0)), 0);
      expect(LedgerBook.perMille(thb(5), thb(-10)), 0);
    });

    test('divide rounds half up to the satang', () {
      expect(LedgerBook.divide(thb(1000), 3), thb(333));
      expect(LedgerBook.divide(thb(1001), 2), thb(501));
      expect(LedgerBook.divide(thb(0), 7), thb(0));
    });

    test('sums only baht postings of the asked account type', () {
      final book = bookOf(fixtureTransactions);

      expect(book.sum(fixtureTransactions, AccountType.income), thb(-5000000));
      expect(
        book.sum(fixtureTransactions, AccountType.expense),
        thb(50000 + 20000 + 800000 + 5000),
      );
    });

    test('knows the earliest month and the accounts of a type', () {
      final book = bookOf(fixtureTransactions);

      expect(book.earliestMonth, DateTime(2026, 8));
      expect(bookOf(const []).earliestMonth, isNull);
      expect(book.accountsOf(AccountType.expense), [
        'Expenses:Food',
        'Expenses:Food:Lunch',
        'Expenses:Rent',
        'Expenses:Transport',
      ]);
    });
  });
}
