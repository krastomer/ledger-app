import 'package:ledger_app/domain/models/money.dart';

/// Parsers for the value formats that appear on Thai bank and broker slips.
abstract final class SlipText {
  static final _amountWithCurrency = RegExp(
    r'^(-?[\d,]+(?:\.\d{1,2})?)\s*(บาท|THB|USD)(/oz)?$',
  );
  static final _plainAmount = RegExp(r'^-?[\d,]+\.\d{2}$');
  static final _account = RegExp(r'^[X\d-]{4,}$');
  static final _quantity = RegExp(r'^\d+(?:\.\d+)?$');
  static final _leadingNoise = RegExp(r'^[\dA-Za-z@®•#&]\s+(?=\S)');
  static final _trailingNoise = RegExp(r'[\s,;|]+$');
  static const _nameTitles = [
    'นางสาว',
    'นาย',
    'นาง',
    'น.ส.',
    'บจก.',
    'บมจ.',
    'หจก.',
    'MR.',
    'MRS.',
    'MS.',
    'MISS',
  ];

  // Month abbreviations by consonant skeleton (see [skeleton]), keeping
  // sara i / sara ii, which tell ม.ค. from มี.ค. and เม.ย. from มิ.ย.
  static const _thaiMonths = {
    'มค': 1,
    'กพ': 2,
    'มีค': 3,
    'มย': 4,
    'พค': 5,
    'มิย': 6,
    'กค': 7,
    'สค': 8,
    'กย': 9,
    'ตค': 10,
    'พย': 11,
    'ธค': 12,
  };
  static const _englishMonths = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec',
  ];

  // `18 ส.ค. 69 17:52 น.` (K PLUS) and `25 ก.ย. 2569 - 08:09` (SCB). The
  // month is matched loosely (dots lost or read as marks) and resolved by
  // skeleton; OCR sometimes reads the time's colon as a dot.
  static final _thaiDate = RegExp(
    r'(\d{1,2})[\s/]*([ก-ฮเ][^\d]{0,10}?)\s*(\d{4}|\d{2})\s*-?\s*'
    r'(\d{1,2})[:.](\d{2})',
  );

  // `24 Sep 2026 - 9:56 AM` and `27 May 2026 - 20:50` (KKP / Dime).
  static final _englishDate = RegExp(
    r'(\d{1,2})\s+([A-Za-z]{3})[a-z]*\s+(\d{4})\s*-?\s*(\d{1,2}):(\d{2})'
    r'(?:\s*([AaPp][Mm]))?',
  );

  /// Thai slips show local time.
  static const _bangkokOffset = Duration(hours: 7);

  /// Evens out how different OCR engines write the same text: sara am
  /// as one code point (Tesseract emits nikhahit + sara aa) and single
  /// spaces.
  static String normalize(String text) => text
      .replaceAll('\u0E4D\u0E32', '\u0E33')
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll(' .', '.')
      .trim();

  /// Thai consonants, ASCII letters and digits (lowercased) and `:` only,
  /// so labels still match when OCR drops or misreads vowels, tone marks,
  /// dots or spaces. [keep] lists extra characters to keep.
  static String skeleton(String text, {String keep = ''}) {
    final out = StringBuffer();
    for (final rune in text.toLowerCase().runes) {
      final isKept =
          (rune >= 0x0E01 && rune <= 0x0E2E) ||
          (rune >= 0x30 && rune <= 0x39) ||
          (rune >= 0x61 && rune <= 0x7A) ||
          rune == 0x3A ||
          keep.runes.contains(rune);
      if (isKept) out.writeCharCode(rune);
    }
    return out.toString();
  }

  /// Reads `150.00 บาท`, `1,000.00 THB`, `-7.64 THB`, `209.47 USD` or
  /// `4,423.66 USD/oz`. With [plainCurrency] set, also accepts a bare
  /// `12,345.67` in that currency.
  static Money? money(String text, {String? plainCurrency}) {
    final t = text.trim();
    final match = _amountWithCurrency.firstMatch(t);
    if (match != null) {
      final currency = match.group(2) == 'บาท' ? 'THB' : match.group(2)!;
      return Money.tryParse(match.group(1)!, currency: currency);
    }
    if (plainCurrency != null && _plainAmount.hasMatch(t)) {
      return Money.tryParse(t, currency: plainCurrency);
    }
    return null;
  }

  static bool isMoney(String text, {String? plainCurrency}) =>
      money(text, plainCurrency: plainCurrency) != null;

  static final _leadingAmount = RegExp(r'^(-?[\d,]+\.\d{2})(?!\d)');

  /// Reads the amount at the start of [text] in [currency], ignoring what
  /// follows. For layouts that always print one currency, where OCR may
  /// garble the unit (`0.00 un` for `0.00 บาท`, `418.01บรม` for `418.01 USD`).
  static Money? leadingMoney(String text, {required String currency}) {
    final match = _leadingAmount.firstMatch(text.trim());
    return match == null
        ? null
        : Money.tryParse(match.group(1)!, currency: currency);
  }

  /// The masked account (`xxx-x-x1234-x`, `X-2468`) or numeric biller ID
  /// in [text], normalized: mask letter always `X` (OCR engines differ in
  /// case, and Tesseract sometimes reads it as `%`), icon glyphs before it
  /// dropped. Null when [text] has none.
  static String? account(String text) {
    String? found;
    for (final token in text.split(' ')) {
      final t = token
          .toUpperCase()
          .replaceAll('%', 'X')
          .replaceAll(RegExp(r'^[^X\d]+|[^X\d]+$'), '');
      if (_account.hasMatch(t) && t.contains(RegExp(r'\d'))) found = t;
    }
    return found;
  }

  static bool isAccount(String text) => account(text) != null;

  /// A bare decimal such as `0.7295008`.
  static bool isQuantity(String text) => _quantity.hasMatch(text.trim());

  /// Drops icon glyphs the OCR read as characters around a name
  /// (`5 นาย ...`, `@ บ นาย ...`, `... PURE,`).
  static String cleanName(String text) {
    var name = text.trim();
    final tokens = name.split(' ');
    for (var i = 1; i < tokens.length && i <= 3; i++) {
      if (_nameTitles.any(tokens[i].startsWith)) {
        name = tokens.sublist(i).join(' ');
        break;
      }
    }
    return name
        .replaceFirst(_leadingNoise, '')
        .replaceFirst(_trailingNoise, '');
  }

  /// Finds a Thai or English slip date/time in [text] and returns it in
  /// UTC. Buddhist Era years (2-digit `69` or 4-digit `2569`) become
  /// Gregorian.
  static DateTime? timestamp(String text) {
    final thai = _thaiDate.firstMatch(text);
    if (thai != null) {
      return _toUtc(
        year: _gregorianYear(int.parse(thai.group(3)!)),
        month: _thaiMonths[skeleton(thai.group(2)!, keep: 'ิี')] ?? 0,
        day: int.parse(thai.group(1)!),
        hour: int.parse(thai.group(4)!),
        minute: int.parse(thai.group(5)!),
      );
    }

    final english = _englishDate.firstMatch(text);
    if (english == null) return null;
    final month = _englishMonths.indexOf(english.group(2)!.toLowerCase()) + 1;
    if (month == 0) return null;
    var hour = int.parse(english.group(4)!);
    final meridiem = english.group(6)?.toUpperCase();
    if (meridiem == 'PM' && hour < 12) hour += 12;
    if (meridiem == 'AM' && hour == 12) hour = 0;
    return _toUtc(
      year: _gregorianYear(int.parse(english.group(3)!)),
      month: month,
      day: int.parse(english.group(1)!),
      hour: hour,
      minute: int.parse(english.group(5)!),
    );
  }

  static int _gregorianYear(int year) {
    if (year < 100) return 2500 + year - 543;
    if (year > 2400) return year - 543;
    return year;
  }

  static DateTime? _toUtc({
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
  }) {
    if (month < 1 || month > 12 || day < 1 || day > 31) return null;
    if (hour > 23 || minute > 59) return null;
    return DateTime.utc(
      year,
      month,
      day,
      hour,
      minute,
    ).subtract(_bangkokOffset);
  }
}
