import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/transaction_detail.dart';
import 'package:ledger_app/domain/models/transaction_kind.dart';
import 'package:ledger_app/domain/use_cases/transaction_detail_use_case.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../testing/fakes/fake_ledger_repository.dart';
import '../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  test('returns the entry with its summary', () async {
    final result = await TransactionDetailUseCase(
      ledgerRepository: FakeLedgerRepository(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      ),
    )('lunch');

    final detail = (result as Ok<TransactionDetail?>).value;
    expect(detail?.transaction.id, 'lunch');
    expect(detail?.summary.kind, TransactionKind.expense);
    expect(detail?.summary.amount, thb(20000));
  });

  test('returns nothing for an id that is not in the ledger', () async {
    final result = await TransactionDetailUseCase(
      ledgerRepository: FakeLedgerRepository(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      ),
    )('gone');

    expect((result as Ok<TransactionDetail?>).value, isNull);
  });

  test('fails when the ledger cannot be read', () async {
    final result = await TransactionDetailUseCase(
      ledgerRepository: FakeLedgerRepository(error: Exception('disk')),
    )('lunch');

    expect(result, isA<Error<TransactionDetail?>>());
  });
}
