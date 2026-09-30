import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/month_transactions.dart';
import 'package:ledger_app/domain/models/transaction_filter.dart';
import 'package:ledger_app/domain/use_cases/month_transactions_use_case.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../testing/fakes/fake_ledger_repository.dart';
import '../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  Future<MonthTransactions> load({
    DateTime? month,
    TransactionFilter filter = const TransactionFilter(),
  }) async {
    final result = await MonthTransactionsUseCase(
      ledgerRepository: FakeLedgerRepository(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      ),
      now: () => fixtureToday,
    )(month: month, filter: filter);
    return switch (result) {
      Ok(:final value) => value,
      Error(:final error) => throw error,
    };
  }

  List<String> ids(MonthTransactions data) => [
    for (final day in data.days) ...day.transactions.map((t) => t.id),
  ];

  test('defaults to the current month with totals', () async {
    final data = await load();

    expect(data.month, DateTime(2026, 9));
    expect(data.income, thb(5000000));
    expect(data.expenses, thb(825000));
    expect(data.net, thb(4175000));
    expect(data.isLatestMonth, isTrue);
  });

  test('groups by day, newest first, with untimed entries last', () async {
    final data = await load();

    expect(data.days.map((d) => d.date), [
      DateTime(2026, 9, 29),
      DateTime(2026, 9, 28),
      DateTime(2026, 9, 25),
    ]);
    expect(ids(data), ['to savings', 'bts', 'lunch', 'rent', 'salary']);
  });

  test('marks today', () async {
    final data = await load();

    expect(data.days.map((d) => d.isToday), [true, false, false]);
  });

  test('bounds navigation by the first transaction and today', () async {
    final data = await load(month: DateTime(2026, 8));

    expect(data.isEarliestMonth, isTrue);
    expect(data.isLatestMonth, isFalse);
    expect(ids(data), ['august food', 'opening']);
  });

  test('searches description and account names, ignoring case', () async {
    final byDescription = await load(
      filter: const TransactionFilter(query: 'LUNCH'),
    );
    final byAccount = await load(
      filter: const TransactionFilter(query: 'expenses:transport'),
    );

    expect(ids(byDescription), ['lunch']);
    expect(ids(byAccount), ['bts']);
  });

  test('requires every search term to match', () async {
    final data = await load(
      filter: const TransactionFilter(query: 'expenses kbank'),
    );

    expect(ids(data), ['lunch', 'rent']);
  });

  test('keeps month totals when filters hide entries', () async {
    final data = await load(
      filter: const TransactionFilter(query: 'no such thing'),
    );

    expect(data.isEmpty, isTrue);
    expect(data.income, thb(5000000));
  });

  test('filters to pending and to entries with a slip', () async {
    final pending = await load(
      filter: const TransactionFilter(pendingOnly: true),
    );
    final withSlip = await load(
      filter: const TransactionFilter(withSlipOnly: true),
    );

    expect(ids(pending), ['rent']);
    expect(ids(withSlip), ['lunch']);
  });

  test('returns an error when the ledger cannot be read', () async {
    final result = await MonthTransactionsUseCase(
      ledgerRepository: FakeLedgerRepository(error: Exception('disk')),
      now: () => fixtureToday,
    )();

    expect(result, isA<Error<MonthTransactions>>());
  });
}
