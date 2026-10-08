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
    final (
      language,
      yearEra,
      hideOnLaunch,
      showJournal,
      keepSlipImages,
      setup,
    ) = await (
      _preferences.getString(_languageKey),
      _preferences.getString(_yearEraKey),
      _preferences.getBool(_hideOnLaunchKey),
      _preferences.getBool(_showJournalKey),
      _preferences.getBool(_keepSlipImagesKey),
      _preferences.getBool(_setupCompleteKey),
    ).wait;
    final failure = _firstError([
      language,
      yearEra,
      hideOnLaunch,
      showJournal,
      keepSlipImages,
      setup,
    ]);
    if (failure != null) return Result.error(failure);
    return Result.ok(
      AppSettings(
        language:
            AppLanguage.values.asNameMap()[_valueOf(language)] ??
            _defaults.language,
        yearEra:
            YearEra.values.asNameMap()[_valueOf(yearEra)] ?? _defaults.yearEra,
        hideOnLaunch: _valueOf(hideOnLaunch) ?? _defaults.hideOnLaunch,
        showJournal: _valueOf(showJournal) ?? _defaults.showJournal,
        keepSlipImages: _valueOf(keepSlipImages) ?? _defaults.keepSlipImages,
        setupComplete: _valueOf(setup) ?? _defaults.setupComplete,
      ),
    );
  }

  @override
  Future<Result<void>> save(AppSettings settings) async {
    final results = await Future.wait([
      _preferences.setString(_languageKey, settings.language.name),
      _preferences.setString(_yearEraKey, settings.yearEra.name),
      _preferences.setBool(_hideOnLaunchKey, settings.hideOnLaunch),
      _preferences.setBool(_showJournalKey, settings.showJournal),
      _preferences.setBool(_keepSlipImagesKey, settings.keepSlipImages),
      _preferences.setBool(_setupCompleteKey, settings.setupComplete),
    ]);
    final failure = _firstError(results);
    return failure == null ? const Result.ok(null) : Result.error(failure);
  }

  static Exception? _firstError(List<Result<Object?>> results) {
    for (final result in results) {
      if (result case Error(:final error)) return error;
    }
    return null;
  }

  static T? _valueOf<T>(Result<T?> result) => switch (result) {
    Ok(:final value) => value,
    Error() => null,
  };
}
