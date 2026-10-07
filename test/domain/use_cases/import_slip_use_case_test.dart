import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/domain/models/posting.dart';
import 'package:ledger_app/domain/models/slip_draft.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../testing/fakes/fake_ledger_repository.dart';
import '../../../testing/fakes/fake_slip_repository.dart';
import '../../../testing/fixtures/ledger_fixtures.dart';
import '../../../testing/fixtures/slip_draft_fixtures.dart';

void main() {
  late FakeLedgerRepository ledger;

  setUp(() {
    ledger = FakeLedgerRepository(
      accounts: fixtureAccounts,
      transactions: fixtureTransactions,
    );
  });

  Future<SlipDraft> draftOf(ParsedSlip slip) async {
    final result = await ImportSlipUseCase(
      slipRepository: FakeSlipRepository({'slip.jpg': slip}),
      ledgerRepository: ledger,
      now: () => fixtureToday,
    ).read('slip.jpg');
    return (result as Ok<SlipDraft>).value;
  }

  test('writes a pending entry in Thai time from the bank account', () async {
    final draft = await draftOf(transferSlip());
    final transaction = draft.transaction;

    expect(transaction?.date, DateTime(2026, 9, 29));
    expect(transaction?.time, const Duration(hours: 9, minutes: 15));
    expect(transaction?.status, TransactionStatus.pending);
    expect(transaction?.code, 'REF-NEW');
    expect(transaction?.slipImagePath, 'slip.jpg');
    expect(transaction?.description, 'Sample Property Co., Ltd.');
    expect(transaction?.postings, [
      Posting(account: ImportSlipUseCase.uncategorized, amount: thb(850000)),
      Posting(account: 'Assets:Bank:KBank', amount: thb(-850000)),
    ]);
    expect(transaction?.isBalanced, isTrue);
    expect(draft.categoryFromHistory, isFalse);
  });

  test('saves the slip image path unless images are not kept', () async {
    Future<String?> savedImage({required bool keepSlipImages}) async {
      final importSlip = ImportSlipUseCase(
        slipRepository: FakeSlipRepository({'slip.jpg': transferSlip()}),
        ledgerRepository: ledger,
        keepSlipImages: keepSlipImages,
        now: () => fixtureToday,
      );
      final draft = await importSlip.read('slip.jpg');
      final transaction = (draft as Ok<SlipDraft>).value.transaction;
      if (transaction == null) fail('no transaction drafted');
      await importSlip.save(transaction);
      return ledger.transactions
          .firstWhere((t) => t.id == transaction.id)
          .slipImagePath;
    }

    expect(await savedImage(keepSlipImages: true), 'slip.jpg');
    expect(await savedImage(keepSlipImages: false), isNull);
  });

  test('reuses the category of an earlier entry for the same payee', () async {
    final draft = await draftOf(transferSlip(payee: 'rent'));

    expect(draft.transaction?.postings.first.account, 'Expenses:Rent');
    expect(draft.categoryFromHistory, isTrue);
  });

  test('adds a fee posting and takes it from the bank too', () async {
    final draft = await draftOf(transferSlip(feeSatang: 1000));

    expect(draft.transaction?.postings.map((p) => p.amount), [
      thb(850000),
      thb(1000),
      thb(-851000),
    ]);
  });

  test('finds an entry already saved with the same reference', () async {
    final draft = await draftOf(transferSlip(reference: 'REF-1'));

    expect(draft.duplicate?.id, 'lunch');
  });

  test('has nothing to write when the slip shows no amount', () async {
    final draft = await draftOf(transferSlip(satang: null));

    expect(draft.transaction, isNull);
    expect(draft.checkOf(SlipField.amount), SlipFieldCheck.check);
  });

  test('asks to check a field read with low confidence', () async {
    final draft = await draftOf(
      transferSlip(confidence: {SlipField.to: 0.3, SlipField.from: 1}),
    );

    expect(draft.checkOf(SlipField.to), SlipFieldCheck.check);
    expect(draft.checkOf(SlipField.from), SlipFieldCheck.ok);
    expect(draft.checkOf(SlipField.fee), SlipFieldCheck.absent);
  });

  test('fails when the image cannot be read', () async {
    final result = await ImportSlipUseCase(
      slipRepository: FakeSlipRepository(const {}),
      ledgerRepository: ledger,
    ).read('blurry.jpg');

    expect(result, isA<Error<SlipDraft>>());
  });
}
