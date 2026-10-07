import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/ledger_check.dart';
import 'package:ledger_app/domain/use_cases/ledger_check_use_case.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../testing/fakes/fake_ledger_repository.dart';
import '../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  test('summarizes what was loaded', () async {
    final result = await LedgerCheckUseCase(
      ledgerRepository: FakeLedgerRepository(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      ),
    )();

    expect(
      (result as Ok<LedgerCheck>).value,
      LedgerCheck(
        transactionCount: fixtureTransactions.length,
        firstMonth: DateTime(2026, 8),
        lastMonth: DateTime(2026, 9),
        unbalancedCount: 0,
        reviewCount: 1,
      ),
    );
  });

  test('returns an error when the ledger cannot be read', () async {
    final result = await LedgerCheckUseCase(
      ledgerRepository: FakeLedgerRepository(error: Exception('disk')),
    )();

    expect(result, isA<Error<LedgerCheck>>());
  });
}
