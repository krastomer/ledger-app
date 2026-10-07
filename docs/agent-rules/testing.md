# Testing

- `test/` mirrors `lib/`; a file `lib/a/b.dart` is tested in
  `test/a/b_test.dart`.
- Test each layer on its own:
  - **Pure logic** (slip parser, money formatting, date conversion):
    plain unit tests, many cases, including messy real-world OCR text.
  - **Repositories**: unit tests with fake services.
  - **Blocs / Cubits**: `blocTest` from `package:bloc_test` with fake
    repositories; assert the exact sequence of emitted states
    (`expect: () => [...]`), including failure paths.
  - **Views**: widget tests of `XxxView` with a `MockBloc` (`bloc_test`
    + `mocktail`) stubbed with `whenListen` / `when(() => bloc.state)`;
    check each state renders and that taps add the right event.
- Use hand-written **fakes** (`FakeTransactionRepository implements
  TransactionRepository`) in `testing/fakes/`. Prefer fakes over mocks;
  use `mocktail` only when a fake is impractical.
- Never hit real platform channels, network or disk in unit/widget
  tests; fake the service instead.
- Test names describe behaviour: `'returns error when amount is missing'`.
- Structure tests as arrange / act / assert; one behaviour per test.
- Every bug fix in parsing or money logic comes with a regression test.

## Screen goldens

- `test/goldens/screens_test.dart` renders every main screen in Thai and
  English on the bundled sample ledger, at iPhone 17 size on 2026-09-29,
  and compares it with the PNGs in `test/goldens/screens/`. Fonts are
  loaded in `test/goldens/flutter_test_config.dart`.
- After a UI change, run `flutter test --update-goldens test/goldens`,
  then open the changed PNGs and check them. This is the usual way to
  look at a screen; use the simulator only for what goldens can't show
  (iOS text rendering, safe areas, the launch screen, real gestures).
- Commit updated PNGs with the change that caused them. Add a golden when
  you add a screen.
- Goldens are rendered on macOS; other platforms draw text slightly
  differently, so run them on macOS or exclude them with
  `flutter test -x golden`.

