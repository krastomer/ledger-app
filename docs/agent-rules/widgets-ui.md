# Widgets and UI

## Composition

- Split large `build` methods into **private widget classes**
  (`class _AmountRow extends StatelessWidget`), not helper methods
  returning `Widget` — classes get their own `BuildContext`, can be
  `const`, and rebuild independently.
- Prefer `StatelessWidget`. Use `StatefulWidget` only for local UI state
  or owning controllers (`TextEditingController`, `AnimationController`,
  `ScrollController`) — and always `dispose()` them.
- Mark constructors and instances `const` whenever possible.
- Leaf widgets take plain data and callbacks, not the bloc, so they stay
  reusable and easy to test. Only `XxxView` and its direct sections read
  the bloc from context.
- Keep `build` pure and cheap: no I/O, no heavy computation, no object
  creation that should be cached (formatters, regexes).

## State in the view

- Rebuild the smallest subtree possible (`BlocBuilder` / `BlocSelector`
  around the part that changes, not the whole `Scaffold`). See
  [bloc.md](bloc.md).
- Represent screen state explicitly (loading / empty / error / data) and
  render every case — no blank screens on error.

## Theming

- All colors come from `Theme.of(context).colorScheme`; all text styles
  from `Theme.of(context).textTheme`. No hard-coded `Color(0x...)` or
  `TextStyle(fontSize: ...)` in feature widgets.
- Theme is defined once in `lib/ui/core/themes/` with Material 3, light
  and dark `ColorScheme.fromSeed`.
- Spacing uses shared constants (e.g. `Dimens.paddingM`), not magic
  numbers scattered across files.
- Semantic colors for money: income/expense colors defined in the theme
  (a `ThemeExtension`), not picked per widget.

## Layout and lists

- Use `ListView.builder` / `SliverList` for lists that can grow
  (transactions); never build long lists with `Column` + `map`.
- Respect `SafeArea` and keyboard insets on forms.
- Support text scaling: avoid fixed heights on text containers; test
  with large font size.
- Layouts must work on small phones (≈ 360 dp wide) and tablets.

## Text and localization

- User-facing strings go through `flutter_localizations` + ARB files
  (`lib/l10n/app_th.arb`, `app_en.arb`); Thai is the primary locale.
  No hard-coded UI strings once l10n is set up.
- Format numbers and dates with `intl` using the current locale; format
  money with the shared `money2` patterns (see
  [domain-ledger.md](domain-ledger.md)).

## Accessibility

- Every icon-only button has a `tooltip` or `Semantics` label.
- Tap targets at least 48×48 dp.
- Don't convey meaning by color alone (income vs expense also uses a
  sign or icon).
