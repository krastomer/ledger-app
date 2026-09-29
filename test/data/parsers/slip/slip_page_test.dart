import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/parsers/slip/slip_page.dart';
import 'package:ledger_app/data/services/ocr_line.dart';

OcrLine _line(String text, double y) =>
    OcrLine(text: text, x: 0.05, y: y, width: 0.2, height: 0.03);

void main() {
  group('SlipPage.label', () {
    test('matches despite dropped marks and spaces', () {
      final page = SlipPage([_line('เล ขทรายการ :', 0.5)]);

      expect(page.label('เลขที่รายการ:'), isNotNull);
    });

    test('matches a long label with one extra character', () {
      final page = SlipPage([_line('คค่าธรรมเนียม:', 0.5)]);

      expect(page.label('ค่าธรรมเนียม:'), isNotNull);
    });

    test('prefers an exact match over a fuzzy one', () {
      final exact = _line('ค่าธรรมเนียม:', 0.6);
      final page = SlipPage([_line('คค่าธรรมเนียม:', 0.5), exact]);

      expect(page.label('ค่าธรรมเนียม:')?.y, exact.y);
    });

    test('does not fuzzy-match short labels', () {
      final page = SlipPage([_line('Tp', 0.5)]);

      expect(page.label('To'), isNull);
    });
  });
}
