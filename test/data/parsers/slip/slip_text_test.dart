import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/parsers/slip/slip_text.dart';
import 'package:ledger_app/domain/models/money.dart';

void main() {
  group('SlipText.timestamp', () {
    test('reads K PLUS dates with a 2-digit Buddhist Era year', () {
      expect(
        SlipText.timestamp('18 ส.ค. 69 17:52 น.'),
        DateTime.utc(2026, 8, 18, 10, 52),
      );
    });

    test('reads SCB dates with a 4-digit Buddhist Era year', () {
      expect(
        SlipText.timestamp('25 ก.ย. 2569 - 08:09'),
        DateTime.utc(2026, 9, 25, 1, 9),
      );
    });

    test('reads English dates with AM/PM', () {
      expect(
        SlipText.timestamp('24 Sep 2026 - 9:56 AM'),
        DateTime.utc(2026, 9, 24, 2, 56),
      );
      expect(
        SlipText.timestamp('27 May 2026 - 10:04 PM'),
        DateTime.utc(2026, 5, 27, 15, 4),
      );
    });

    test('treats 12 AM as midnight and 12 PM as noon', () {
      expect(
        SlipText.timestamp('1 Jan 2026 - 12:30 AM'),
        DateTime.utc(2025, 12, 31, 17, 30),
      );
      expect(
        SlipText.timestamp('1 Jan 2026 - 12:30 PM'),
        DateTime.utc(2026, 1, 1, 5, 30),
      );
    });

    test('reads 24-hour English dates', () {
      expect(
        SlipText.timestamp('27 May 2026 - 20:50'),
        DateTime.utc(2026, 5, 27, 13, 50),
      );
    });

    test('finds the date inside a longer line', () {
      expect(
        SlipText.timestamp('Status (As of 27 May 2026 - 20:50 )'),
        DateTime.utc(2026, 5, 27, 13, 50),
      );
    });

    test('tolerates OCR dropping or misreading the dots of a Thai month', () {
      expect(
        SlipText.timestamp('25 กุย. 2569 - 08:09'),
        DateTime.utc(2026, 9, 25, 1, 9),
      );
      expect(
        SlipText.timestamp('18 ส. ค. 69 17:52 น.'),
        DateTime.utc(2026, 8, 18, 10, 52),
      );
    });

    test('reads a time whose colon came out as a dot', () {
      expect(
        SlipText.timestamp('25 ก.ย. 69 13.25 น.'),
        DateTime.utc(2026, 9, 25, 6, 25),
      );
    });

    test('tells ม.ค. from มี.ค. and เม.ย. from มิ.ย.', () {
      expect(SlipText.timestamp('1 ม.ค. 69 10:00')?.month, 1);
      expect(SlipText.timestamp('1 มี.ค. 69 10:00')?.month, 3);
      expect(SlipText.timestamp('1 เม.ย. 69 10:00')?.month, 4);
      expect(SlipText.timestamp('1 มิ.ย. 69 10:00')?.month, 6);
    });

    test('returns null for an unknown Thai month', () {
      expect(SlipText.timestamp('1 ขข. 69 10:00'), isNull);
    });

    test('returns null without a date', () {
      expect(SlipText.timestamp('โอนเงินสำเร็จ'), isNull);
    });

    test('returns null for an impossible time', () {
      expect(SlipText.timestamp('1 Jan 2026 - 25:00'), isNull);
    });
  });

  group('SlipText.money', () {
    test('reads baht', () {
      expect(SlipText.money('150.00 บาท'), const Money(15000));
    });

    test('reads THB and USD suffixes', () {
      expect(SlipText.money('1,000.00 THB'), const Money(100000));
      expect(SlipText.money('209.47 USD'), const Money(20947, currency: 'USD'));
    });

    test('reads a per-ounce price', () {
      expect(
        SlipText.money('4,423.66 USD/oz'),
        const Money(442366, currency: 'USD'),
      );
    });

    test('reads a bare amount only when a currency is given', () {
      expect(SlipText.money('12,345.67'), isNull);
      expect(
        SlipText.money('12,345.67', plainCurrency: 'THB'),
        const Money(1234567),
      );
    });

    test('does not treat a masked account as money', () {
      expect(SlipText.money('X-2468', plainCurrency: 'THB'), isNull);
    });
  });

  group('SlipText.leadingMoney', () {
    test('reads the amount and ignores a garbled unit', () {
      expect(SlipText.leadingMoney('0.00 un', currency: 'THB'), const Money(0));
      expect(
        SlipText.leadingMoney('418.01บรม', currency: 'USD'),
        const Money(41801, currency: 'USD'),
      );
    });

    test('rejects quantities with more than two decimals', () {
      expect(SlipText.leadingMoney('0.2192531', currency: 'USD'), isNull);
    });
  });

  group('SlipText.isAccount', () {
    test('accepts masked accounts and biller IDs', () {
      expect(SlipText.isAccount('xxX-X-x1234-x'), isTrue);
      expect(SlipText.isAccount('X-2468'), isTrue);
      expect(SlipText.isAccount('202609250000001'), isTrue);
    });

    test('rejects names and bank names', () {
      expect(SlipText.isAccount('ธ.กสิกรไทย'), isFalse);
      expect(SlipText.isAccount('xxxx'), isFalse);
    });
  });

  test('SlipText.normalize joins a split sara am and collapses spaces', () {
    expect(SlipText.normalize(' จ\u0E4D\u0E32นวน:   x '), 'จำนวน: x');
  });

  group('SlipText.account', () {
    test('uses one mask letter case', () {
      expect(SlipText.account(' xxX-X-x1234-x '), 'XXX-X-X1234-X');
    });

    test('reads a mask letter misread as %', () {
      expect(SlipText.account('%-2468'), 'X-2468');
    });

    test('skips an icon glyph before the account', () {
      expect(SlipText.account('@ x-1357'), 'X-1357');
    });

    test('drops stray symbols around the account', () {
      expect(SlipText.account('*%%%-%-%5678-%'), 'XXX-X-X5678-X');
    });

    test('returns null without an account', () {
      expect(SlipText.account('Scan to Verify'), isNull);
    });
  });

  test(
    'SlipText.skeleton keeps only consonants, letters, digits and colons',
    () {
      expect(
        SlipText.skeleton('เลขที่รายการ:'),
        SlipText.skeleton('เล ขทรายการ :'),
      );
      expect(SlipText.skeleton('Slip ID'), 'slipid');
    },
  );

  group('SlipText.cleanName', () {
    test('drops a stray icon glyph before the name', () {
      expect(SlipText.cleanName('5 นาย สมชาย ใจดี'), 'นาย สมชาย ใจดี');
    });

    test('drops icon glyphs before a name title', () {
      expect(SlipText.cleanName('@ บ นาย สมชาย ใ.'), 'นาย สมชาย ใ.');
    });

    test('drops trailing punctuation', () {
      expect(
        SlipText.cleanName('BIGC ONE BANGKOK PURE,'),
        'BIGC ONE BANGKOK PURE',
      );
    });

    test('keeps names without noise', () {
      expect(SlipText.cleanName('MR. SOMCHAI JAIDEE'), 'MR. SOMCHAI JAIDEE');
    });
  });
}
