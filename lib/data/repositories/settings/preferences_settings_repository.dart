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
  static const _showJournalKey = 'settings.showJournal';
  static const _keepSlipImagesKey = 'settings.keepSlipImages';
  static const _setupCompleteKey = 'settings.setupComplete';
  static const _defaults = AppSettings();

  final PreferencesService _preferences;

  @override
  Future<Result<AppSettings>> load() async {
    final texts = <String, String?>{};
    for (final key in [_languageKey, _yearEraKey]) {
      switch (await _preferences.getString(key)) {
        case Ok(:final value):
          texts[key] = value;
        case Error(:final error):
          return Result.error(error);
      }
    }
    final flags = <String, bool?>{};
    for (final key in [
      _hideOnLaunchKey,
      _showJournalKey,
      _keepSlipImagesKey,
      _setupCompleteKey,
    ]) {
      switch (await _preferences.getBool(key)) {
        case Ok(:final value):
          flags[key] = value;
        case Error(:final error):
          return Result.error(error);
      }
    }
    return Result.ok(
      AppSettings(
        language:
            AppLanguage.values.asNameMap()[texts[_languageKey]] ??
            _defaults.language,
        yearEra:
            YearEra.values.asNameMap()[texts[_yearEraKey]] ?? _defaults.yearEra,
        hideOnLaunch: flags[_hideOnLaunchKey] ?? _defaults.hideOnLaunch,
        showJournal: flags[_showJournalKey] ?? _defaults.showJournal,
        keepSlipImages: flags[_keepSlipImagesKey] ?? _defaults.keepSlipImages,
        setupComplete: flags[_setupCompleteKey] ?? _defaults.setupComplete,
      ),
    );
  }

  @override
  Future<Result<void>> save(AppSettings settings) async {
    final writes = [
      () => _preferences.setString(_languageKey, settings.language.name),
      () => _preferences.setString(_yearEraKey, settings.yearEra.name),
      () => _preferences.setBool(_hideOnLaunchKey, settings.hideOnLaunch),
      () => _preferences.setBool(_showJournalKey, settings.showJournal),
      () => _preferences.setBool(_keepSlipImagesKey, settings.keepSlipImages),
      () => _preferences.setBool(_setupCompleteKey, settings.setupComplete),
    ];
    for (final write in writes) {
      final result = await write();
      if (result is Error<void>) return result;
    }
    return const Result.ok(null);
  }
}
