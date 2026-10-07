import 'package:ledger_app/utils/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  PreferencesService({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  Future<Result<String?>> getString(String key) async {
    try {
      return Result.ok(await _preferences.getString(key));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<void>> setString(String key, String value) async {
    try {
      await _preferences.setString(key, value);
      return const Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<bool?>> getBool(String key) async {
    try {
      return Result.ok(await _preferences.getBool(key));
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<void>> setBool(String key, bool value) async {
    try {
      await _preferences.setBool(key, value);
      return const Result.ok(null);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
