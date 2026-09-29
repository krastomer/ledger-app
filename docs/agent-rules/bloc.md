# Bloc (state management)

State management uses `flutter_bloc`. Follow the official Bloc docs
(https://bloclibrary.dev) and naming conventions
(https://bloclibrary.dev/naming-conventions/). Do not mix in other state
management (Provider `ChangeNotifier`, Riverpod, GetX).

## Bloc or Cubit

- **Cubit** by default — simple screens where public methods map 1:1 to
  actions (settings, filters, a form).
- **Bloc** when you need event traceability or event transformers
  (debounce search, drop duplicate submits, restart on new input), or
  the flow has several steps (slip import: pick → OCR → parse → review →
  save).
- One bloc per feature/screen. Split a bloc when its state holds
  unrelated concerns.

## Events (Bloc only)

- Named in past tense, as something that happened, from the UI's point
  of view: `<Subject><Noun?><Verb>`
  — `SlipImageSelected`, `SlipSaveRequested`, `TransactionDeleted`.
- Declared as a `sealed class XxxEvent` with `final class` subclasses, in
  `xxx_event.dart` as a `part of` the bloc file.
- Events carry only the data needed (IDs, input values) — never
  `BuildContext`, widgets or controllers.

## States

- States are `freezed` classes (see [architecture.md](architecture.md)).
- Pick one style per bloc:
  - **Single class + status enum** (preferred for forms and lists that
    keep data while loading): fields `status`, data, `error`, with
    `@Default(...)` values and
    `enum XxxStatus { initial, loading, success, failure }`. Update with
    `state.copyWith(...)`; `copyWith(error: null)` clears a field.
  - **Sealed union** when states hold different data:
    `const factory XxxState.initial() = XxxInitial;`,
    `.loadInProgress()`, `.loadSuccess(...)`, `.loadFailure(...)`.
- Use `switch` on sealed states / status enums in widgets so every case
  is handled.
- Errors in state are a typed value (enum or domain error), not a raw
  exception string; widgets map it to a localized message.

## Inside a bloc

- Depend only on repositories / use-cases, injected via constructor.
- Never import `package:flutter/material.dart` or take a `BuildContext`.
  No navigation, dialogs or snackbars — emit state and let the UI react.
- Blocs do not reference other blocs. Share data through a repository
  (e.g. a `Stream` it exposes) or coordinate in the UI with
  `BlocListener`.
- Each event handler is an `on<Event>` with a private `_onXxx` method.
- Always `emit` new state objects (`state.copyWith(...)`); never mutate.
- Don't `emit` after the bloc is closed; with `emit.forEach` /
  `emit.onEach` for repository streams, subscriptions are cleaned up
  automatically — prefer them over manual `listen`.
- Choose a transformer from `bloc_concurrency` when it matters:
  `droppable()` for submit/save, `restartable()` for search/OCR re-run,
  `sequential()` for ordered writes.
- Override `close()` to dispose anything the bloc created itself.

## In widgets

- `XxxPage` creates the bloc with `BlocProvider`; `XxxView` builds UI.
  This keeps the view testable with a mock bloc.
- `context.read<XxxBloc>()` in callbacks (`onPressed`), never in `build`.
- `context.watch` / `context.select` or `BlocBuilder` / `BlocSelector`
  in `build`. Prefer `BlocSelector` / `context.select` to rebuild only
  when the part you use changes.
- Side effects (navigation, snackbar, dialog) go in `BlocListener` (or
  `BlocConsumer` when you need both), with `listenWhen` to avoid
  repeats.
- Use `buildWhen` / `listenWhen` instead of comparing states manually.
- `setState` is fine only for purely local, ephemeral UI state (focus,
  expanded tile, animation) — never for data from repositories.

## Observability

- A single `AppBlocObserver` (registered in `main.dart`) logs
  transitions and errors in debug builds only, and must not log state
  contents that include slip or money data (see
  [domain-ledger.md](domain-ledger.md)).
