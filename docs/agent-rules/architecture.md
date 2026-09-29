# Architecture

Layered architecture based on the official Flutter app architecture guide
(https://docs.flutter.dev/app-architecture) and the Bloc architecture
(https://bloclibrary.dev/architecture/): presentation → business logic
(Bloc) → data (repository → service), with unidirectional data flow.

## Layers

```
Widget  ──events──▶  Bloc / Cubit  ──calls──▶  Repository  ──▶  Service
   ▲                      │                    (source of truth)   (DB / file / platform channel)
   └─────state (stream)───┘
```

- **Service** — thin wrapper around one external source (SQLite, file
  system, MethodChannel, HTTP). No business logic, no state. Returns raw
  data / API models.
- **Repository** — single source of truth for one kind of data
  (e.g. `TransactionRepository`, `SlipRepository`). Combines services,
  caches, maps API models → domain models, handles errors. Declared as an
  `abstract interface class` with a concrete implementation so tests can
  swap in fakes. Has no dependency on Flutter or Bloc.
- **Bloc / Cubit** — business logic for one screen or feature. Receives
  events (or method calls for a Cubit), talks to repositories (or
  use-cases), emits immutable states. Never talks to services directly.
  Rules in [bloc.md](bloc.md).
- **Widgets** — only render state and add events. Allowed logic: simple
  `if` for showing/hiding, animation, layout, routing. No parsing, no
  calculations, no I/O.
- **Use-case / domain layer** — optional. Add one only when logic
  combines several repositories or is reused by several blocs
  (e.g. `ImportSlipUseCase`: OCR → parse → dedupe → save).

Data flows down (repository → bloc → widget); events flow up. A layer
may only depend on the layer directly below it.

## Folder structure

```
lib/
  main.dart                 # bootstrap + DI wiring only
  app.dart                  # MultiRepositoryProvider + MaterialApp.router
  routing/                  # go_router config, route names
  config/                   # env, constants
  domain/
    models/                 # immutable domain models (Transaction, Slip)
    use_cases/              # optional
  data/
    services/               # e.g. slip_ocr_service.dart, database_service.dart
    repositories/
      transaction/
        transaction_repository.dart        # abstract interface
        transaction_repository_local.dart  # implementation
  ui/
    core/                   # shared widgets, theme, extensions
      themes/
      widgets/
    <feature>/              # e.g. slip_import/, transactions/, summary/
      bloc/
        <feature>_bloc.dart     # or <feature>_cubit.dart
        <feature>_event.dart    # part of <feature>_bloc.dart
        <feature>_state.dart    # part of <feature>_bloc.dart
      view/
        <feature>_page.dart     # provides the bloc
        <feature>_view.dart     # consumes the bloc
      widgets/                  # feature-only sub-widgets
  utils/                    # Result, formatters
test/                       # mirrors lib/
testing/                    # shared fakes and fixtures
```

- `ui/` is organised by feature; `data/` is organised by data type
  (repositories are shared across features).
- `lib/main.dart` must stay small: create services/repositories,
  `runApp`.

## Dependency injection

- Repositories are created once in `main.dart` and provided with
  `MultiRepositoryProvider` at the top of the tree.
- Blocs are created in the feature's `XxxPage` with `BlocProvider`, taking
  repositories through their constructor
  (`create: (context) => XxxBloc(repository: context.read())`).
- Never create a repository or service inside a widget or bloc with
  `SomeRepository()`; always inject it.
- No global singletons / service locators for app data.

## Data models

- Domain models and bloc states are immutable `freezed` classes
  (freezed 3 syntax):

  ```dart
  @freezed
  abstract class Transaction with _$Transaction {
    const factory Transaction({
      required String id,
      required Money amount,
      String? note,
    }) = _Transaction;
  }
  ```

  Use `sealed class` + named factories for unions. Add custom getters or
  methods with a private `const Transaction._();` constructor.
- Don't use `equatable` or hand-written `==` / `hashCode` / `copyWith`.
- Keep API/DB models separate from domain models when their shape
  differs (e.g. raw `OcrLine` from the channel vs. parsed `Slip`).
- JSON / map parsing happens in the data layer, never in widgets or blocs.

## Errors and async

- Repositories and services return `Result<T>` (`Ok` / `Error`) instead
  of throwing across layer boundaries (see `lib/utils/result.dart`).
- Blocs turn errors into explicit failure states; widgets never wrap
  calls in `try/catch`.
- Always check `context.mounted` after an `await` before using
  `BuildContext`.

## Navigation

- Use `go_router` with named routes defined in `lib/routing/routes.dart`.
- Pass IDs in routes, not whole objects; the destination bloc loads data
  from the repository.
- Navigation is triggered from `BlocListener`, never from inside a bloc.
