import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../testing/fakes/fake_ledger_repository.dart';
import '../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  late FakeLedgerRepository repository;
  late EditTransactionUseCase edit;

  setUp(() {
    repository = FakeLedgerRepository(
      accounts: fixtureAccounts,
      transactions: fixtureTransactions,
    );
    edit = EditTransactionUseCase(ledgerRepository: repository);
  });

  test('marks a pending entry cleared', () async {
    await edit.markCleared('rent');

    expect(
      repository.transactions.firstWhere((t) => t.id == 'rent').status,
      TransactionStatus.cleared,
    );
  });

  test('moves postings to another account', () async {
    await edit.recategorize('lunch', from: 'Expenses:Food:Lunch', to: 'X:Y');

    expect(
      repository.transactions
          .firstWhere((t) => t.id == 'lunch')
          .postings
          .map((p) => p.account),
      ['X:Y', 'Assets:Bank:KBank'],
    );
  });

  test('deletes an entry', () async {
    await edit.delete('bts');

    expect(repository.transactions.map((t) => t.id), isNot(contains('bts')));
  });

  test('fails for an unknown id', () async {
    expect(await edit.markCleared('nope'), isA<Error<void>>());
  });

  test('reports which entry was missing', () async {
    final result = await edit.recategorize('nope', from: 'a', to: 'b');

    expect(
      (result as Error<void>).error,
      isA<TransactionNotFoundException>().having((e) => e.id, 'id', 'nope'),
    );
  });

  test('leaves other postings on an entry alone when recategorizing', () async {
    await edit.recategorize('lunch', from: 'Expenses:Food:Lunch', to: 'X:Y');

    final lunch = repository.transactions.firstWhere((t) => t.id == 'lunch');
    expect(lunch.postings.last.account, 'Assets:Bank:KBank');
    expect(lunch.isBalanced, isTrue);
  });

  test('passes a ledger failure on', () async {
    final failing = EditTransactionUseCase(
      ledgerRepository: FakeLedgerRepository(error: Exception('disk')),
    );

    expect(await failing.markCleared('rent'), isA<Error<void>>());
    expect(await failing.delete('rent'), isA<Error<void>>());
  });
}
