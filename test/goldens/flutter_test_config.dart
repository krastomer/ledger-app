import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Goldens need the app's real fonts; tests otherwise draw every glyph as
/// a box.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final manifest = await rootBundle.loadString('FontManifest.json');
  for (final entry in jsonDecode(manifest) as List<Object?>) {
    if (entry case {
      'family': final String family,
      'fonts': final List<Object?> fonts,
    }) {
      final loader = FontLoader(family);
      for (final font in fonts) {
        if (font case {'asset': final String asset}) {
          loader.addFont(rootBundle.load(asset));
        }
      }
      await loader.load();
    }
  }
  await testMain();
}
