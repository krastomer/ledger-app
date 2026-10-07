# ledger_app

Personal ledger app (Flutter, Android + iOS). Core feature: read Thai bank
transfer slips with on-device OCR and turn them into ledger entries.

- Flutter stable 3.47.x, Dart SDK ^3.13
- OCR: Apple Vision via `MethodChannel('ledger_app/slip_ocr')`
  (`ios/Runner/AppDelegate.swift`); Android not implemented yet

## Commands

```bash
flutter pub get
flutter analyze            # must be clean before finishing a task
dart format .              # format all Dart code
flutter test               # unit + widget tests
flutter test --update-goldens test/goldens   # re-render screen PNGs
flutter run                # run on a booted simulator/device
dart run build_runner build -d   # regenerate freezed code
```

## Detailed rules

Read the relevant file in `docs/agent-rules/` before working in that area:

| File | Read when |
|---|---|
| [architecture.md](docs/agent-rules/architecture.md) | adding a feature, screen, repository, service, or model |
| [bloc.md](docs/agent-rules/bloc.md) | writing or using a Bloc/Cubit, events, states |
| [dart-style.md](docs/agent-rules/dart-style.md) | writing any Dart code |
| [widgets-ui.md](docs/agent-rules/widgets-ui.md) | working in `lib/ui/` |
| [domain-ledger.md](docs/agent-rules/domain-ledger.md) | touching transactions, postings, money, dates, slips, OCR parsing |
| [platform-channels.md](docs/agent-rules/platform-channels.md) | touching `ios/`, `android/`, or a MethodChannel |
| [sync.md](docs/agent-rules/sync.md) | touching the database, IDs, deletes, repositories that write, or anything sync-related |
| [testing.md](docs/agent-rules/testing.md) | writing or changing tests |

## Core rules (always apply)

- **Architecture:** layered + repository pattern (official Flutter guide).
  Widget → Bloc/Cubit → Repository → Service. No business logic, parsing
  or I/O in widgets. Dependencies are injected, never constructed inside
  widgets/blocs.
- **State management is `flutter_bloc` only.** Cubit by default, Bloc
  for multi-step flows or event transformers. Blocs never touch
  `BuildContext`, navigation or other blocs; side effects go in
  `BlocListener`.
- **Money uses `package:money2`, never `double`** (floating-point
  rounding: `0.1 + 0.2 != 0.3`). Build from satang or strings
  (`Money.fromInt(12550, isoCode: 'THB')` = ฿125.50), persist as integer
  minor units + currency code, format only for display.
- **Privacy:** slip data stays on-device; never log slip text, amounts,
  names or account numbers.
- **Immutable models**, sound null safety, avoid `!` and `dynamic`.
- Prefer small private widget classes over `Widget _buildX()` helpers;
  `const` everywhere possible; colors/text styles from `Theme.of(context)`.
- **Minimal comments.** Don't sprinkle comments or doc comments; only
  comment genuinely complex/non-obvious logic, or when asked.
- Platform channels are only touched by their wrapping service in
  `lib/data/services/`.

## Working agreements

- Keep changes small and in the style of the surrounding code.
- Run `dart format` and `flutter analyze` before calling a task done;
  run `flutter test` when logic changed.
- Ask before adding a new package to `pubspec.yaml`; prefer packages
  published by `dart.dev` / `flutter.dev` or well-maintained ones.
- Models and bloc states use `freezed`. Never edit generated files
  (`*.freezed.dart`, `*.g.dart`, `l10n` output); change the source and
  run `dart run build_runner build -d`. Generated files are committed.
