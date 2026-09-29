# Dart style

Follow Effective Dart (https://dart.dev/effective-dart) and the lints in
`analysis_options.yaml`. `dart format` output is always correct; don't
hand-format against it.

## Naming

- Files and folders: `snake_case.dart` (`slip_ocr_service.dart`).
- Types, enums, extensions, typedefs: `UpperCamelCase`.
- Variables, functions, parameters, named constants: `lowerCamelCase`
  (`const defaultCurrency = 'THB'`, not `DEFAULT_CURRENCY`).
- Private members start with `_`. Keep a class/function private unless
  another file needs it.
- Suffix by role: `XxxPage` / `XxxView`, `XxxBloc` / `XxxCubit`,
  `XxxEvent`, `XxxState`, `XxxRepository`, `XxxService`, `XxxUseCase`.
  A feature's page, view, bloc, events and state share the prefix.
- Booleans read as questions: `isLoading`, `hasError`, `canSave`.
- Avoid abbreviations except well-known ones (`id`, `url`, `ocr`).

## Language features

- Prefer `final` for locals; `const` wherever possible (constructors,
  widget instances, collections).
- Sound null safety: avoid `!`. If you need it, the type is probably
  wrong — use a local variable, early return, or pattern match.
- Use `switch` expressions and patterns for enums and sealed classes;
  make state hierarchies `sealed` so switches are exhaustive.
- Use collection `if` / `for` and spreads instead of building lists
  imperatively.
- Use `async`/`await`, not `.then()` chains. Never leave a `Future`
  un-awaited by accident; use `unawaited(...)` when intentional.
- No `dynamic` unless crossing a platform-channel or JSON boundary;
  cast to concrete types immediately at that boundary.

## Organisation

- One public class per file (small private helpers may share it).
- Imports: `dart:` → `package:` → relative, each group sorted. Use
  `package:ledger_app/...` imports across top-level folders, relative
  imports within a feature.
- Class member order: constructors → fields → getters → public methods
  → private methods; in widgets, `build` last among overrides.
- Keep functions short; if a block needs a comment to explain what it
  does, extract it into a well-named function instead.

## Comments

Default is **no comment**. Code should explain itself through names,
small functions and types.

- Only comment when:
  - the logic is genuinely complex or non-obvious (e.g. the slip parser's
    heuristics, Buddhist Era conversion, a workaround for a platform bug);
  - the code does something surprising on purpose and a reader would
    otherwise "fix" it;
  - the user explicitly asks for comments / docs.
- Don't add comments that restate the code, narrate steps
  (`// call repository`, `// emit loading`), or describe what you changed
  (`// added for X`, `// new`).
- Don't add `///` doc comments by default, even on public APIs; a clear
  name and signature is enough. Add one only when the behaviour can't be
  read from the signature (units, side effects, error cases).
- When a comment is warranted, keep it short and explain *why*, not
  *what*.
- Don't delete existing meaningful comments when editing nearby code.
- `TODO(username): ...` format for TODOs.
- No commented-out code in commits.

## Logging

- No `print`. Use `debugPrint` for temporary debugging, or
  `dart:developer` `log()` / a logger in services.
- Never log slip contents, account numbers, names or amounts
  (see [domain-ledger.md](domain-ledger.md)).
