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
