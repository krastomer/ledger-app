import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/repositories/ledger/hledger_ledger_repository.dart';
import 'package:ledger_app/data/services/ledger_asset_service.dart';
import 'package:ledger_app/data/parsers/hledger/parsed_ledger.dart';
import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/utils/result.dart';

class _FakeLedgerSource implements LedgerAssetService {
  _FakeLedgerSource(this.result);

  Result<String> result;
  var reads = 0;

  @override
  Future<Result<String>> read() async {
    reads++;
    return result;
  }
}

void main() {
  Map<String, Object?> posting(String account, int satang) => {
    'paccount': account,
    'ptype': 'RegularPosting',
    'pamount': [
      {
        'acommodity': 'THB',
        'acost': null,
        'aquantity': {'decimalMantissa': satang, 'decimalPlaces': 2},
      },
    ],
  };
  final export = jsonEncode([
    {
      'tindex': 1,
      'tdate': '2026-09-01',
      'tstatus': 'Cleared',
      'tcode': '',
      'tdescription': 'Lunch',
      'ttags': <Object?>[],
      'tpostings': [
        posting('Expenses:Food', 6000),
        posting('Assets:Cash', -6000),
      ],
    },
  ]);

  test('returns accounts and transactions from the export', () async {
    final repository = HledgerLedgerRepository(
      source: _FakeLedgerSource(Result.ok(export)),
    );

    final transactions = await repository.getTransactions();
    final accounts = await repository.getAccounts();

    expect(
      (transactions as Ok<List<LedgerTransaction>>).value.single.description,
      'Lunch',
    );
    expect(accounts, isA<Ok>());
  });

  test('reads the source only once', () async {
    final source = _FakeLedgerSource(Result.ok(export));
    final repository = HledgerLedgerRepository(source: source);

    await repository.getAccounts();
    await repository.getTransactions();

    expect(source.reads, 1);
  });

  test('returns an import error when the export has issues', () async {
    final repository = HledgerLedgerRepository(
      source: _FakeLedgerSource(const Result.ok('garbage')),
    );

    final result = await repository.getTransactions();

    expect(
      result,
      isA<Error<List<LedgerTransaction>>>().having(
        (e) => e.error,
        'error',
        isA<LedgerImportException>(),
      ),
    );
  });

  test('retries after a failed read', () async {
    final source = _FakeLedgerSource(Result.error(Exception('missing')));
    final repository = HledgerLedgerRepository(source: source);

    expect(await repository.getTransactions(), isA<Error>());
    source.result = Result.ok(export);

    expect(await repository.getTransactions(), isA<Ok>());
  });

  group('edits', () {
    late HledgerLedgerRepository repository;
    List<LedgerTransaction> current(Result<List<LedgerTransaction>> result) =>
        (result as Ok<List<LedgerTransaction>>).value;

    setUp(() {
      repository = HledgerLedgerRepository(
        source: _FakeLedgerSource(Result.ok(export)),
      );
    });

    test('a saved entry replaces the imported one with its id', () async {
      final lunch = current(await repository.getTransactions()).single;

      await repository.save(lunch.copyWith(description: 'Late lunch'));

      expect(
        current(await repository.getTransactions()).single.description,
        'Late lunch',
      );
    });

    test('a new entry is added and a deleted one hidden', () async {
      final lunch = current(await repository.getTransactions()).single;

      await repository.save(lunch.copyWith(id: 'new'));
      await repository.delete(lunch.id);

      expect(current(await repository.getTransactions()).map((t) => t.id), [
        'new',
      ]);
    });

    test('refuses an entry that does not balance', () async {
      final lunch = current(await repository.getTransactions()).single;

      final result = await repository.save(
        lunch.copyWith(postings: [lunch.postings.first]),
      );

      expect(result, isA<Error<void>>());
    });

    test('tells listeners about each change', () async {
      final lunch = current(await repository.getTransactions()).single;
      final changes = <void>[];
      final subscription = repository.changes.listen(changes.add);

      await repository.save(lunch);
      await repository.delete(lunch.id);
      await pumpEventQueue();

      expect(changes, hasLength(2));
      await subscription.cancel();
    });
  });

  test('replaceAll swaps the ledger, drops edits and notifies', () async {
    final repository = HledgerLedgerRepository(
      source: _FakeLedgerSource(Result.ok(export)),
    );
    await repository.getTransactions();
    final changes = expectLater(repository.changes, emits(null));

    await repository.replaceAll(accounts: const [], transactions: const []);

    await changes;
    expect(
      (await repository.getTransactions() as Ok<List<LedgerTransaction>>).value,
      isEmpty,
    );
  });

  test('describes an unreadable export by how many problems it has', () {
    const exception = LedgerImportException([
      LedgerIssue(kind: LedgerIssueKind.malformed),
      LedgerIssue(entry: 3, kind: LedgerIssueKind.badAmount),
    ]);

    expect(exception.toString(), 'LedgerImportException(2 issues)');
  });

  test('fails to list accounts when the export cannot be read', () async {
    final repository = HledgerLedgerRepository(
      source: _FakeLedgerSource(Result.error(Exception('missing'))),
    );

    expect(await repository.getAccounts(), isA<Error<List<Account>>>());
  });

  test('retries reading after a failure', () async {
    final source = _FakeLedgerSource(Result.error(Exception('missing')));
    final repository = HledgerLedgerRepository(source: source);

    await repository.getTransactions();
    source.result = Result.ok(export);
    final retried = await repository.getTransactions();

    expect(retried, isA<Ok<List<LedgerTransaction>>>());
    expect(source.reads, 2);
  });
}
