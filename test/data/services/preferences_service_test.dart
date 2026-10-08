import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/services/preferences_service.dart';
import 'package:ledger_app/utils/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakePreferences extends Fake implements SharedPreferencesAsync {
  _FakePreferences({this.error});

  final Exception? error;
  final values = <String, Object>{};

  @override
  Future<String?> getString(String key) async {
    if (error case final error?) throw error;
    return values[key] as String?;
  }

  @override
  Future<void> setString(String key, String value) async {
    if (error case final error?) throw error;
    values[key] = value;
  }

  @override
  Future<bool?> getBool(String key) async {
    if (error case final error?) throw error;
    return values[key] as bool?;
  }

  @override
  Future<void> setBool(String key, bool value) async {
    if (error case final error?) throw error;
    values[key] = value;
  }
}

void main() {
  test('stores and reads text', () async {
    final service = PreferencesService(preferences: _FakePreferences());

    expect(await service.setString('language', 'th'), isA<Ok<void>>());
    final result = await service.getString('language');
    final missing = await service.getString('other');

    expect((result as Ok<String?>).value, 'th');
    expect((missing as Ok<String?>).value, isNull);
  });

  test('stores and reads flags', () async {
    final service = PreferencesService(preferences: _FakePreferences());

    expect(await service.setBool('hide', true), isA<Ok<void>>());
    final result = await service.getBool('hide');
    final missing = await service.getBool('other');

    expect((result as Ok<bool?>).value, isTrue);
    expect((missing as Ok<bool?>).value, isNull);
  });

  test('returns an error instead of throwing when storage fails', () async {
    final service = PreferencesService(
      preferences: _FakePreferences(error: Exception('disk')),
    );

    expect(await service.getString('k'), isA<Error<String?>>());
    expect(await service.setString('k', 'v'), isA<Error<void>>());
    expect(await service.getBool('k'), isA<Error<bool?>>());
    expect(await service.setBool('k', true), isA<Error<void>>());
  });
}
