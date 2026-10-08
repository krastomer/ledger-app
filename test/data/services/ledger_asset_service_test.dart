import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/services/ledger_asset_service.dart';
import 'package:ledger_app/utils/result.dart';

class _MapBundle extends CachingAssetBundle {
  _MapBundle(this.assets);

  final Map<String, String> assets;

  @override
  Future<ByteData> load(String key) async {
    final text = assets[key];
    if (text == null) throw FlutterError('Unable to load asset: "$key".');
    return ByteData.sublistView(Uint8List.fromList(utf8.encode(text)));
  }
}

void main() {
  test('reads the bundled export as text', () async {
    final service = LedgerAssetService(
      path: 'assets/ledger/test.json',
      bundle: _MapBundle({'assets/ledger/test.json': '[]'}),
    );

    final result = await service.read();

    expect((result as Ok<String>).value, '[]');
  });

  test('returns an error when the asset is not bundled', () async {
    final service = LedgerAssetService(
      path: 'assets/ledger/missing.json',
      bundle: _MapBundle({}),
    );

    final result = await service.read();

    expect(
      (result as Error<String>).error.toString(),
      contains('missing.json'),
    );
  });
}
