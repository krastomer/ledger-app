import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/income_statement.dart';
import 'package:ledger_app/domain/use_cases/income_statement_use_case.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../testing/fakes/fake_ledger_repository.dart';
import '../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  Future<IncomeStatement> statementFor(DateTime? month) async {
    final result = await IncomeStatementUseCase(
      ledgerRepository: FakeLedgerRepository(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      ),
      now: () => fixtureToday,
    )(month: month);
    return switch (result) {
      Ok(:final value) => value,
      Error(:final error) => throw error,
    };
  }

  test('defaults to the current month', () async {
    final statement = await statementFor(null);

    expect(statement.month, DateTime(2026, 9));
    expect(statement.isLatestMonth, isTrue);
  });

  test('sums income, expenses and net for the month', () async {
    final statement = await statementFor(null);

    expect(statement.income, thb(5000000));
    expect(statement.expenses, thb(825000));
    expect(statement.net, thb(4175000));
    expect(statement.savingsPerMille, 835);
  });

  test('builds an account tree per side, largest first', () async {
    final statement = await statementFor(null);

    expect(statement.expenseTree.account, 'Expenses');
    expect(statement.expenseTree.children.map((c) => (c.account, c.amount)), [
      ('Expenses:Rent', thb(800000)),
      ('Expenses:Food', thb(20000)),
      ('Expenses:Transport', thb(5000)),
    ]);
    final food = statement.expenseTree.children[1];
    expect(food.children.map((c) => c.name), ['Lunch']);
    expect(food.ownAmount, thb(0));
    expect(statement.incomeTree.children.map((c) => (c.name, c.amount)), [
      ('Salary', thb(5000000)),
    ]);
  });

  test(
    'keeps postings made directly on an account as its own amount',
    () async {
      final statement = await statementFor(DateTime(2026, 8));
      final food = statement.expenseTree.children.single;

      expect(food.ownAmount, thb(50000));
      expect(food.hasChildren, isFalse);
    },
  );

  test('shares expenses against income', () async {
    final statement = await statementFor(null);

    expect(statement.expensesPerMille, 165);
  });

  test('reports an earlier month without a savings rate', () async {
    final statement = await statementFor(DateTime(2026, 8, 15));

    expect(statement.month, DateTime(2026, 8));
    expect(statement.isLatestMonth, isFalse);
    expect(statement.income, thb(0));
    expect(statement.expenses, thb(50000));
    expect(statement.net, thb(-50000));
    expect(statement.savingsPerMille, isNull);
  });

  test('bounds navigation by the first transaction and today', () async {
    final statement = await statementFor(DateTime(2026, 8));

    expect(statement.earliestMonth, DateTime(2026, 8));
    expect(statement.isEarliestMonth, isTrue);
    expect(statement.isLatestMonth, isFalse);
  });

  test('is empty for a month without postings', () async {
    final statement = await statementFor(DateTime(2026, 10));

    expect(statement.isEmpty, isTrue);
  });

  test('returns an error when the ledger cannot be read', () async {
    final result = await IncomeStatementUseCase(
      ledgerRepository: FakeLedgerRepository(error: Exception('disk')),
      now: () => fixtureToday,
    )();

    expect(result, isA<Error<IncomeStatement>>());
  });

  test('totals spending per day and averages it up to today', () async {
    final daily = (await statementFor(null)).dailySpend;

    expect(daily.days, hasLength(30));
    expect(daily.days[27], thb(825000));
    expect(daily.days[28], thb(0));
    expect(daily.today, 29);
    expect(daily.elapsedDays, 29);
    expect(daily.average, thb(28448));
    expect(daily.isFuture(30), isTrue);
  });

  test('names the category that took most of the peak day', () async {
    final daily = (await statementFor(null)).dailySpend;

    expect(daily.peakDay, 28);
    expect(daily.peakAmount, thb(825000));
    expect(daily.peakCategory, 'Rent');
  });

  test('averages a past month over all of its days', () async {
    final daily = (await statementFor(DateTime(2026, 8))).dailySpend;

    expect(daily.days, hasLength(31));
    expect(daily.today, isNull);
    expect(daily.elapsedDays, 31);
    expect(daily.average, thb(1613));
    expect(daily.isFuture(31), isFalse);
    expect(daily.peakCategory, 'Food');
  });

  test('has no peak in a month without spending', () async {
    final daily = (await statementFor(DateTime(2026, 7))).dailySpend;

    expect(daily.average, thb(0));
    expect(daily.peakDay, isNull);
    expect(daily.peakAmount, isNull);
  });
}
