# ledger_app

A personal double-entry ledger for Android and iOS. Its core feature is
reading Thai bank transfer slips with on-device OCR and turning them into
ledger entries. Slip data never leaves the device.

The UI is a terminal-style design (IBM Plex Mono / IBM Plex Sans Thai) with
Thai and English localization.

## Features

- Inbox of slips with a review screen before anything is posted
- Transactions made of postings (double-entry), amounts as integer minor
  units via `money2`, never `double`
- Accounts, transaction detail and reports screens
- First-run setup: start a new ledger or import an hledger JSON export
- Works fully offline; syncing to a server is planned as an optional add-on

## Status

Early development. OCR uses Apple Vision on iOS through a platform channel
(`ledger_app/slip_ocr`); Android OCR is not finished yet.

## Getting started

Requires Flutter stable 3.47.x (Dart ^3.13).

```bash
flutter pub get
flutter run
```

Run against a ledger exported from your own hledger journal:

```bash
tool/export_ledger.sh <main.journal> [YYYY-MM]
flutter run --dart-define=LEDGER_ASSET=assets/ledger/local.json
```

`assets/ledger/local.json` and `testing/fixtures/slips_private/` are
gitignored because they hold personal data. Do not commit them.

## Development

```bash
flutter analyze
dart format .
flutter test
flutter test --update-goldens test/goldens   # re-render screen PNGs
dart run build_runner build -d               # regenerate freezed code
```

Architecture is layered (Widget → Bloc/Cubit → Repository → Service) using
`flutter_bloc`. Project conventions live in [AGENTS.md](AGENTS.md) and
[docs/agent-rules/](docs/agent-rules/).

## License

All rights reserved. No license is granted for this code yet. Bundled IBM
Plex fonts are under the SIL Open Font License (see `assets/fonts/OFL.txt`).
