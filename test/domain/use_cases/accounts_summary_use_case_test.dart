import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/accounts_summary.dart';
import 'package:ledger_app/domain/use_cases/accounts_summary_use_case.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../testing/fakes/fake_ledger_repository.dart';
import '../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  Future<AccountsSummary> load() async {
    final result = await AccountsSummaryUseCase(
      ledgerRepository: FakeLedgerRepository(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      ),
      now: () => fixtureToday,
    )();
    return switch (result) {
      Ok(:final value) => value,
      Error(:final error) => throw error,
    };
  }

  AccountSection section(AccountsSummary summary, AccountType type) =>
      summary.sections.singleWhere((s) => s.type == type);

  test('totals net worth from assets and liabilities', () async {
    final summary = await load();

    expect(summary.assets, thb(14130000));
    expect(summary.liabilities, thb(105000));
    expect(summary.netWorth, thb(14025000));
  });

  test('builds the asset tree with balances over all dates', () async {
    final assets = section(await load(), AccountType.asset);

    final root = assets.balance.single;
    expect(root.name, 'Assets');
    expect(root.amount, thb(14130000));
    final bank = root.children.single;
    expect(bank.name, 'Bank');
    expect(bank.children.map((c) => (c.name, c.amount)), [
      ('KBank', thb(14030000)),
      ('Savings', thb(100000)),
    ]);
  });

  test('shows liabilities as the amount owed', () async {
    final liabilities = section(await load(), AccountType.liability);

    expect(liabilities.balance.single.amount, thb(105000));
  });

  test('month change only counts this month', () async {
    final assets = section(await load(), AccountType.asset);

    final bank = assets.monthChange.single.children.single;
    expect(bank.children.map((c) => (c.name, c.amount)), [
      ('KBank', thb(4080000)),
      ('Savings', thb(100000)),
    ]);
  });

  test('income and expenses are this month in both views', () async {
    final summary = await load();
    final income = section(summary, AccountType.income);
    final expenses = section(summary, AccountType.expense);

    expect(income.balance.single.amount, thb(5000000));
    expect(income.monthChange, income.balance);
    expect(expenses.balance.single.amount, thb(825000));
    expect(expenses.monthChange, expenses.balance);
  });

  test('is empty without transactions', () async {
    final result = await AccountsSummaryUseCase(
      ledgerRepository: FakeLedgerRepository(accounts: fixtureAccounts),
      now: () => fixtureToday,
    )();

    expect(result, isA<Ok<AccountsSummary>>());
    expect((result as Ok<AccountsSummary>).value.isEmpty, isTrue);
  });

  test('returns an error when the ledger cannot be read', () async {
    final result = await AccountsSummaryUseCase(
      ledgerRepository: FakeLedgerRepository(error: Exception('disk')),
    )();

    expect(result, isA<Error<AccountsSummary>>());
  });
}
