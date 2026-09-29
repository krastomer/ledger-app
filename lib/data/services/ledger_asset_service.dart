import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ledger_app/utils/result.dart';

/// Reads a bundled ledger export until the app has its own database.
class LedgerAssetService {
  LedgerAssetService({required this._path, AssetBundle? bundle})
    : _bundle = bundle ?? rootBundle;

  final String _path;
  final AssetBundle _bundle;

  Future<Result<String>> read() async {
    try {
      return Result.ok(await _bundle.loadString(_path));
    } on FlutterError catch (error) {
      return Result.error(Exception(error.message));
    }
  }
}
