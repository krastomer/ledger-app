# Ledger domain rules

## Money

Amounts use `Money` from `package:money2`
(https://pub.dev/packages/money2). Never `double`, never a hand-rolled
money class.

- Create from minor units or strings, never from a `double`:
  `Money.fromInt(12550, isoCode: 'THB')` (฿125.50) or
  `Money.parse(text, isoCode: 'THB')`. Don't use `Money.fromNum`, and
  don't multiply/divide by a `double`.
- Always carry the currency (`THB` default); never add or compare
  amounts of different currencies without an explicit conversion.
- Persist as minor units + ISO code (`minorUnits`, `currency.isoCode`),
  e.g. SQLite `amount INTEGER, currency TEXT`. Not as text or `REAL`.
- Splitting an amount uses `allocationAccordingTo` so no satang is lost.
- Format only at the UI edge, with the shared patterns in
  `lib/utils/money_format.dart` (e.g. `'S#,##0.00'`); no ad-hoc
  `format(...)` patterns in widgets.
- Sign convention: store positive amounts plus a `TransactionType`
  (income / expense / transfer), not negative numbers.

## Dates and time

- Store timestamps in UTC (`DateTime.toUtc()`); convert to local time
  only for display.
- Thai slips may show Buddhist Era years (e.g. 2568 = 2025) and Thai
  month abbreviations (ม.ค., ก.พ., ...). The slip parser must convert
  them to Gregorian; display format follows the user's locale setting.

## Slip / OCR data

- OCR output (`OcrLine` from the platform channel) is raw data; parsing
  into a `Slip` (amount, date/time, sender, receiver, bank, reference no.)
  happens in the data/domain layer and is covered by unit tests with
  real-world text fixtures.
- Parsers return a result with per-field confidence / missing fields;
  the UI lets the user confirm or correct before saving.
- Use the slip reference number to detect duplicate imports.

## Privacy

- Slip images and parsed data contain personal financial data (names,
  masked account numbers, amounts). Keep everything on-device.
- Never log, print, or send slip text, amounts, names or account numbers
  to analytics/crash reports.
- Don't commit real slip images or real OCR output as test fixtures;
  anonymise them first.
