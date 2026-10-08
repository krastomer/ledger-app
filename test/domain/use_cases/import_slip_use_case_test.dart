import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/money.dart' as slip_money;
import 'package:ledger_app/domain/models/posting.dart';
import 'package:ledger_app/domain/models/slip.dart';
import 'package:ledger_app/domain/models/slip_draft.dart';
import 'package:ledger_app/domain/models/slip_order.dart';
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

  test('reuses the latest entry for a payee when many share a day', () async {
    final day = DateTime(2026, 9, 1);
    ledger = FakeLedgerRepository(
      accounts: fixtureAccounts,
      transactions: [
        for (var i = 0; i < 120; i++)
          LedgerTransaction(
            id: 'cafe $i',
            date: day,
            description: 'Cafe Amazon',
            postings: [
              Posting(account: 'Expenses:Cat $i', amount: thb(100)),
              Posting(account: 'Assets:Bank:KBank', amount: thb(-100)),
            ],
          ),
      ],
    );

    final draft = await draftOf(transferSlip(payee: 'Cafe Amazon'));

    expect(draft.transaction?.postings.first.account, 'Expenses:Cat 119');
  });

  group('broker orders', () {
    ParsedSlip orderSlip(SlipKind kind) => ParsedSlip(
      Slip(
        source: SlipSource.dime,
        kind: kind,
        timestamp: DateTime.utc(2026, 9, 29, 2, 15),
        reference: 'ORD-1',
        amount: const slip_money.Money(300000),
        order: const SlipOrder(symbol: 'NVDA', quantity: '0.5', unit: 'shares'),
      ),
    );

    setUp(() {
      ledger = FakeLedgerRepository(
        accounts: fixtureAccounts,
        transactions: [
          ...fixtureTransactions,
          fixtureTransaction('top up', DateTime(2026, 9, 20), {
            'Assets:Investments:Dime': thb(100000),
            'Assets:Bank:KBank': thb(-100000),
          }),
        ],
      );
    });

    test('a buy moves money from the paired account into the broker', () async {
      final draft = await draftOf(orderSlip(SlipKind.buy));

      expect(draft.transaction?.description, 'Buy NVDA 0.5 shares');
      expect(draft.transaction?.postings, [
        Posting(account: 'Assets:Investments:Dime', amount: thb(300000)),
        Posting(account: 'Assets:Bank:KBank', amount: thb(-300000)),
      ]);
      expect(draft.sourceAccount, 'Assets:Investments:Dime');
      expect(draft.categoryFromHistory, isTrue);
    });

    test('a sell moves money out of the broker', () async {
      final draft = await draftOf(orderSlip(SlipKind.sell));

      expect(draft.transaction?.description, 'Sell NVDA 0.5 shares');
      expect(draft.transaction?.postings, [
        Posting(account: 'Assets:Bank:KBank', amount: thb(300000)),
        Posting(account: 'Assets:Investments:Dime', amount: thb(-300000)),
      ]);
    });

    test('falls back to uncategorized without a paired account', () async {
      ledger = FakeLedgerRepository(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      );

      final draft = await draftOf(orderSlip(SlipKind.buy));

      expect(draft.categoryFromHistory, isFalse);
      expect(
        draft.transaction?.postings.last.account,
        ImportSlipUseCase.uncategorized,
      );
    });
  });

  test('books the entry today when the slip shows no time', () async {
    final draft = await draftOf(
      ParsedSlip(
        Slip(
          source: SlipSource.scb,
          kind: SlipKind.payment,
          reference: 'REF-X',
          amount: const slip_money.Money(1500),
        ),
      ),
    );

    expect(draft.transaction?.date, DateTime(2026, 9, 29));
    expect(draft.transaction?.time, isNull);
    expect(draft.transaction?.description, 'scb');
    expect(draft.sourceAccount, 'Assets:Bank:SCB');
  });

  test('lists every account in the ledger, plus the slip account', () async {
    final draft = await draftOf(transferSlip());

    expect(draft.accounts, contains('Assets:Bank:KBank'));
    expect(draft.accounts, contains('Expenses:Rent'));
    expect(draft.accounts, [...draft.accounts]..sort());
  });

  test('picks the images through the slip repository', () async {
    final result = await ImportSlipUseCase(
      slipRepository: FakeSlipRepository(const {}, picked: ['a.jpg', 'b.jpg']),
      ledgerRepository: ledger,
    ).pickImages();

    expect((result as Ok<List<String>>).value, ['a.jpg', 'b.jpg']);
  });

  test('fails when the ledger cannot be read', () async {
    final result = await ImportSlipUseCase(
      slipRepository: FakeSlipRepository({'slip.jpg': transferSlip()}),
      ledgerRepository: FakeLedgerRepository(error: Exception('disk')),
    ).read('slip.jpg');

    expect(result, isA<Error<SlipDraft>>());
  });
}
