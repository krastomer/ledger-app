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
}
