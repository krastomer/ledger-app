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
  static const _hideOnLaunchKey = 'settings.hideOnLaunch';
  static const _showZeroBalanceKey = 'settings.showZeroBalance';
  static const _keepSlipImagesKey = 'settings.keepSlipImages';
  static const _defaults = AppSettings();

  final PreferencesService _preferences;

  @override
  Future<Result<AppSettings>> load() async {
    final language = await _preferences.getString(_languageKey);
    final yearEra = await _preferences.getString(_yearEraKey);
    final hideOnLaunch = await _preferences.getBool(_hideOnLaunchKey);
    final showZeroBalance = await _preferences.getBool(_showZeroBalanceKey);
    final keepSlipImages = await _preferences.getBool(_keepSlipImagesKey);
    return switch ((
      language,
      yearEra,
      hideOnLaunch,
      showZeroBalance,
      keepSlipImages,
    )) {
      (
        Ok(value: final language),
        Ok(value: final yearEra),
        Ok(value: final hideOnLaunch),
        Ok(value: final showZeroBalance),
        Ok(value: final keepSlipImages),
      ) =>
        Result.ok(
          AppSettings(
            language:
                AppLanguage.values.asNameMap()[language] ?? _defaults.language,
            yearEra: YearEra.values.asNameMap()[yearEra] ?? _defaults.yearEra,
            hideOnLaunch: hideOnLaunch ?? _defaults.hideOnLaunch,
            showZeroBalance: showZeroBalance ?? _defaults.showZeroBalance,
            keepSlipImages: keepSlipImages ?? _defaults.keepSlipImages,
          ),
        ),
      (Error(:final error), _, _, _, _) ||
      (_, Error(:final error), _, _, _) ||
      (_, _, Error(:final error), _, _) ||
      (_, _, _, Error(:final error), _) ||
      (_, _, _, _, Error(:final error)) => Result.error(error),
    };
  }

  @override
  Future<Result<void>> save(AppSettings settings) async {
    final writes = [
      () => _preferences.setString(_languageKey, settings.language.name),
      () => _preferences.setString(_yearEraKey, settings.yearEra.name),
      () => _preferences.setBool(_hideOnLaunchKey, settings.hideOnLaunch),
      () => _preferences.setBool(_showZeroBalanceKey, settings.showZeroBalance),
      () => _preferences.setBool(_keepSlipImagesKey, settings.keepSlipImages),
    ];
    for (final write in writes) {
      final result = await write();
      if (result is Error<void>) return result;
    }
    return const Result.ok(null);
  }
}
