import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/data/parsers/slip/slip_parser.dart';
import 'package:ledger_app/data/services/ocr_line.dart';
import 'package:ledger_app/domain/models/money.dart';
import 'package:ledger_app/domain/models/slip.dart';
import 'package:ledger_app/domain/models/slip_order.dart';
import 'package:ledger_app/domain/models/slip_party.dart';

import '../../../../testing/fixtures/slip_fixtures.dart';

void main() {
  const parser = SlipParser();

  ParsedSlip parseFixture(String name, {bool withFileName = true}) {
    final fixture = SlipFixture.load('slips/$name.json');
    final parsed = parser.parse(
      fixture.lines,
      fileName: withFileName ? fixture.fileName : null,
    );
    expect(parsed, isNotNull, reason: '$name matched no layout');
    return parsed!;
  }

  group('K PLUS', () {
    test('reads a transfer', () {
      final parsed = parseFixture('kplus_transfer');

      expect(
        parsed.slip,
        Slip(
          source: SlipSource.kbank,
          kind: SlipKind.transfer,
          timestamp: DateTime.utc(2026, 8, 18, 10, 52),
          reference: '016230170000ATF00001',
          amount: const Money(25000),
          fee: const Money(0),
          from: const SlipParty(name: 'นาย สมชาย ใ', account: 'XXX-X-X1234-X'),
          to: const SlipParty(
            name: 'นาย สมหญิง รักดี',
            account: 'XXX-X-X5678-X',
          ),
        ),
      );
      expect(parsed.isComplete, isTrue);
    });

    test('reads a merchant payment, skipping logos read as text', () {
      final parsed = parseFixture('kplus_payment');

      expect(parsed.slip.kind, SlipKind.payment);
      expect(parsed.slip.timestamp, DateTime.utc(2026, 9, 25, 6, 25));
      expect(parsed.slip.amount, const Money(4500));
      expect(
        parsed.slip.to,
        const SlipParty(
          name: 'BIGC ONE BANGKOK PURE',
          account: '202609250000001',
        ),
      );
      expect(parsed.isComplete, isTrue);
    });

    test('reads the reference from the slip without a filename', () {
      final parsed = parseFixture('kplus_transfer', withFileName: false);

      expect(parsed.slip.reference, '016230170000ATF00001');
      expect(parsed.confidence[SlipField.reference], 1.0);
    });
  });

  group('SCB', () {
    test('reads a transfer with a bare amount and right-aligned parties', () {
      final parsed = parseFixture('scb_transfer');

      expect(
        parsed.slip,
        Slip(
          source: SlipSource.scb,
          kind: SlipKind.transfer,
          timestamp: DateTime.utc(2026, 9, 25, 1, 9),
          reference: '2026092500A1bcdEfGhIjK001',
          amount: const Money(1234567),
          from: const SlipParty(name: 'นาย สมชาย ใ.', account: 'XXX-XXX456-7'),
          to: const SlipParty(name: 'นาย สมชาย ใจดี', account: 'X-2468'),
        ),
      );
      expect(parsed.isComplete, isTrue);
    });

    test('prefers the filename reference over OCR', () {
      final parsed = parseFixture('scb_transfer');

      expect(parsed.confidence[SlipField.reference], 1.0);
    });
  });

  group('KKP', () {
    test('reads a transfer, ignoring the logo read as text', () {
      final parsed = parseFixture('kkp_transfer');

      expect(
        parsed.slip,
        Slip(
          source: SlipSource.kkp,
          kind: SlipKind.transfer,
          timestamp: DateTime.utc(2026, 9, 24, 2, 56),
          reference: '600000000001',
          amount: const Money(200000),
          fee: const Money(0),
          from: const SlipParty(name: 'MR. SOMCHAI JAIDEE', account: 'X-2468'),
          to: const SlipParty(name: 'MR. SOMCHAI JAIDEE', account: 'X-1357'),
        ),
      );
      expect(parsed.isComplete, isTrue);
    });
  });

  group('Dime', () {
    test('reads a stock buy from the two-column table', () {
      final parsed = parseFixture('dime_stock_buy_nvda');

      expect(
        parsed.slip,
        Slip(
          source: SlipSource.dime,
          kind: SlipKind.buy,
          timestamp: DateTime.utc(2026, 5, 27, 15, 4),
          reference: 'STKBML20260527030408000001',
          amount: const Money(499994),
          fee: const Money(0),
          order: const SlipOrder(
            symbol: 'NVDA',
            quantity: '0.7295008',
            unit: 'shares',
            price: Money(20947, currency: 'USD'),
            foreignAmount: Money(15281, currency: 'USD'),
            exchangeRate: '32.72',
          ),
        ),
      );
      expect(parsed.isComplete, isTrue);
    });

    test('reads another stock buy with the same layout', () {
      final parsed = parseFixture('dime_stock_buy_tsm');

      expect(parsed.slip.amount, const Money(299970));
      expect(
        parsed.slip.order,
        const SlipOrder(
          symbol: 'TSM',
          quantity: '0.2192531',
          unit: 'shares',
          price: Money(41801, currency: 'USD'),
          foreignAmount: Money(9165, currency: 'USD'),
          exchangeRate: '32.73',
        ),
      );
    });

    test('reads a gold buy', () {
      final parsed = parseFixture('dime_gold_buy');

      expect(
        parsed.slip,
        Slip(
          source: SlipSource.dime,
          kind: SlipKind.buy,
          timestamp: DateTime.utc(2026, 5, 27, 13, 50),
          reference: 'GLDMTSBML2026052720503700003',
          amount: const Money(299983),
          fee: const Money(0),
          order: const SlipOrder(
            symbol: 'MTS-GOLD',
            quantity: '0.0207',
            unit: 'oz',
            price: Money(442366, currency: 'USD'),
            foreignAmount: Money(9157, currency: 'USD'),
            exchangeRate: '32.71',
          ),
        ),
      );
      expect(parsed.isComplete, isTrue);
    });

    test('joins the order ID wrapped over two lines without a filename', () {
      final parsed = parseFixture('dime_stock_buy_nvda', withFileName: false);

      expect(parsed.slip.reference, 'STKBML20260527030408000001');
    });
  });

  test('returns null for text that is not a known slip', () {
    const lines = [
      OcrLine(text: 'Hello', x: 0.1, y: 0.1, width: 0.2, height: 0.02),
    ];

    expect(parser.parse(lines), isNull);
  });

  test('reports missing fields instead of failing', () {
    final fixture = SlipFixture.load('slips/kplus_transfer.json');
    final withoutAmount = [
      for (final line in fixture.lines)
        if (!line.text.contains('บาท')) line,
    ];

    final parsed = parser.parse(withoutAmount)!;

    expect(parsed.missing, {SlipField.amount});
    expect(parsed.slip.fee, isNull);
  });

  // Real (non-anonymised) OCR output kept out of git; runs only where it
  // exists. Checks that every field was found, not the values.
  final private = Directory('testing/fixtures/slips_private');
  group('private fixtures', skip: !private.existsSync(), () {
    for (final file
        in private.existsSync()
            ? (private.listSync().whereType<File>().toList()
                ..sort((a, b) => a.path.compareTo(b.path)))
            : const <File>[]) {
      test('parses ${file.uri.pathSegments.last} completely', () {
        final fixture = SlipFixture.fromFile(file);
        final parsed = parser.parse(fixture.lines, fileName: fixture.fileName);

        expect(parsed, isNotNull);
        expect(parsed!.missing, isEmpty);
      });
    }
  });
}
