# Native code and platform channels

- Each channel is wrapped by exactly one Dart **service** in
  `lib/data/services/` (e.g. `SlipOcrService`). No other Dart code
  touches `MethodChannel` directly.
- Channel names are namespaced: `ledger_app/<feature>`
  (current: `ledger_app/slip_ocr`, method `recognize`).
- Keep the Dart ⇄ native contract documented next to the service:
  method names, argument types, returned map keys and their types.
  Change both sides together.
- Arguments and results are plain maps/lists of primitives. Convert to
  typed Dart models at the service boundary and cast defensively.
- Native side runs heavy work (Vision OCR) off the main thread and always
  calls `result(...)` exactly once, returning a `FlutterError` with a
  stable error code on failure.
- Handle `MissingPluginException` / `PlatformException` in the service
  and return a `Result` error, so a platform without the plugin fails
  gracefully.
- Prefer an existing, well-maintained plugin over custom native code
  when one covers the need; if native code grows, consider `pigeon` for
  type-safe channels.
- iOS: Swift only. Android: Kotlin only.
- Permission usage strings (`Info.plist` `NS...UsageDescription`,
  Android manifest) must describe the real use in plain language.
