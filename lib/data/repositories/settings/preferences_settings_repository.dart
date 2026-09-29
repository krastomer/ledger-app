import 'package:ledger_app/data/services/preferences_service.dart';
import 'package:ledger_app/domain/models/app_language.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/utils/result.dart';

import 'settings_repository.dart';

class PreferencesSettingsRepository implements SettingsRepository {
  PreferencesSettingsRepository({required this._preferences});

  static const _languageKey = 'settings.language';
  static const _yearEraKey = 'settings.yearEra';
  static const _defaults = AppSettings();

  final PreferencesService _preferences;

  @override
  Future<Result<AppSettings>> load() async {
    final language = await _preferences.getString(_languageKey);
    final yearEra = await _preferences.getString(_yearEraKey);
    return switch ((language, yearEra)) {
      (Ok(value: final language), Ok(value: final yearEra)) => Result.ok(
        AppSettings(
          language:
              AppLanguage.values.asNameMap()[language] ?? _defaults.language,
          yearEra: YearEra.values.asNameMap()[yearEra] ?? _defaults.yearEra,
        ),
      ),
      (Error(:final error), _) ||
      (_, Error(:final error)) => Result.error(error),
    };
  }

  @override
  Future<Result<void>> save(AppSettings settings) async {
    final language = await _preferences.setString(
      _languageKey,
      settings.language.name,
    );
    if (language is Error<void>) return language;
    return _preferences.setString(_yearEraKey, settings.yearEra.name);
  }
}
