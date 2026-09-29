import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/home_summary.dart';
import 'package:ledger_app/domain/models/transaction_kind.dart';
import 'package:ledger_app/domain/use_cases/home_summary_use_case.dart';
import 'package:ledger_app/utils/result.dart';
import 'package:money2/money2.dart';

import '../../../testing/fakes/fake_ledger_repository.dart';
import '../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  Future<HomeSummary> summarize(FakeLedgerRepository repository) async {
    final result = await HomeSummaryUseCase(
      ledgerRepository: repository,
      now: () => fixtureToday,
    )();
    return switch (result) {
      Ok(:final value) => value,
      Error(:final error) => throw error,
    };
  }

  final repository = FakeLedgerRepository(
    accounts: fixtureAccounts,
    transactions: fixtureTransactions,
  );

  test('sums balances across all dates', () async {
    final summary = await summarize(repository);

    expect(summary.assets, thb(14130000));
    expect(summary.liabilities, thb(105000));
    expect(summary.netWorth, thb(14025000));
  });

  test('sums income and expenses for the current month only', () async {
    final summary = await summarize(repository);

    expect(summary.monthIncome, thb(5000000));
    expect(summary.monthExpenses, thb(825000));
    expect(summary.monthNet, thb(4175000));
  });

  test('groups top spending by second-level account', () async {
    final summary = await summarize(repository);

    expect(
      summary.topSpending.map((c) => (c.account, c.amount, c.sharePerMille)),
      [
        ('Expenses:Rent', thb(800000), 969),
        ('Expenses:Food', thb(20000), 24),
        ('Expenses:Transport', thb(5000), 6),
      ],
    );
  });

  test('orders recent by date, then time, with untimed entries last', () async {
    final summary = await summarize(repository);

    expect(summary.recent.map((t) => t.id), [
      'to savings',
      'bts',
      'lunch',
      'rent',
      'salary',
    ]);
  });

  test('summarizes each recent transaction by kind', () async {
    final summary = await summarize(repository);
    final byId = {for (final t in summary.recent) t.id: t};

    expect(byId['bts']?.kind, TransactionKind.expense);
    expect(byId['bts']?.amount, thb(5000));
    expect(byId['bts']?.from, 'Credit card');
    expect(byId['bts']?.to, 'Transport');
    expect(byId['salary']?.kind, TransactionKind.income);
    expect(byId['salary']?.amount, thb(5000000));
    expect(byId['to savings']?.kind, TransactionKind.transfer);
    expect(byId['to savings']?.amount, thb(100000));
    expect(byId['lunch']?.hasSlip, isTrue);
    expect(byId['rent']?.isPending, isTrue);
  });

  test('counts pending transactions', () async {
    final summary = await summarize(repository);

    expect(summary.pendingCount, 1);
  });

  test('ignores postings in other currencies', () async {
    final summary = await summarize(
      FakeLedgerRepository(
        accounts: fixtureAccounts,
        transactions: [
          fixtureTransaction('usd', fixtureToday, {
            'Assets:Broker': Money.fromInt(10000, isoCode: 'USD'),
            'Equity:Opening': Money.fromInt(-10000, isoCode: 'USD'),
          }),
        ],
      ),
    );

    expect(summary.assets, thb(0));
  });

  test('returns an error when the repository fails', () async {
    final result = await HomeSummaryUseCase(
      ledgerRepository: FakeLedgerRepository(error: Exception('disk')),
      now: () => fixtureToday,
    )();

    expect(result, isA<Error<HomeSummary>>());
  });
}
