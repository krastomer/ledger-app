# Ledger domain rules

## Double-entry model

The ledger is hledger-style double-entry (https://hledger.org).

- A `LedgerTransaction` has two or more `Posting`s (account + signed
  `Money`). Per currency, a transaction's postings sum to zero; positive
  debits the account, negative credits it. Validate this in the domain
  layer before saving.
- Accounts are colon-separated hierarchies (`ค่าใช้จ่าย:อาหาร`,
  `Assets:Bank:KBank`). Names can be in any language, so each top-level
  account declares its `AccountType` (asset / liability / equity /
  income / expense) instead of the type being guessed from the name.
  When syncing with the hledger journal, names must match its English
  accounts (see [sync.md](sync.md)).
- On input, one posting may leave its amount blank; it is inferred as
  whatever balances the transaction, as in hledger. Store the inferred
  amount, so every stored posting has one.
- Income / expense / transfer is a UI shortcut that presets postings,
  not a stored field. Derive it from the account types when displaying.
- Balances are sums of postings. Liabilities and income are naturally
  negative; flip the sign only for display.
- A transaction has a status matching hledger's: unmarked, pending (`!`)
  or cleared (`*`).
- A slip's reference number is the transaction `code` (hledger's
  `(CODE)`), which is also what duplicate detection keys on.

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
- Persist as signed minor units + ISO code (`minorUnits`,
  `currency.isoCode`), e.g. SQLite `amount INTEGER, currency TEXT`. Not as
  text or `REAL`.
- Splitting an amount uses `allocationAccordingTo` so no satang is lost.
- Format only at the UI edge, with the shared patterns in
  `lib/utils/money_format.dart` (e.g. `'S#,##0.00'`); no ad-hoc
  `format(...)` patterns in widgets.
- The slip parser still uses the older `lib/domain/models/money.dart`;
  new code uses money2, and the parser moves over when it is next touched.

## Dates and time

- A transaction has a **required calendar date** and an **optional
  time**. Store them as the local date and wall-clock time the user sees
  (e.g. `date TEXT '2026-09-29'`, `time TEXT '14:05'`). Never convert
  them to UTC, or a late-night entry moves to another day.
- Sort same-day transactions by time when present; untimed ones go
  after timed ones, then by entry order.
- `Slip.timestamp` is a UTC instant. When a slip becomes a transaction,
  take its date and time in Thai time (UTC+7), which is what the slip
  shows, not the device's time zone.
- System timestamps (`created_at`, `deleted_at`, change-log entries) are
  UTC instants.
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

## hledger export

- The time goes in a `; time:HH:MM` tag.
- The slip reference goes in the transaction code: `2026-09-29 * (REF123) …`.
- Status maps to `!` / `*` / nothing.

## Privacy

- Slip images and parsed data contain personal financial data (names,
  masked account numbers, amounts). Keep everything on-device.
- Never log, print, or send slip text, amounts, names or account numbers
  to analytics/crash reports.
- Don't commit real slip images or real OCR output as test fixtures;
  anonymise them first.
