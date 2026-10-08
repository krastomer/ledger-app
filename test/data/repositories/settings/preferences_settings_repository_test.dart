import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/repositories/settings/preferences_settings_repository.dart';
import 'package:ledger_app/domain/models/app_language.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../../testing/fakes/fake_preferences_service.dart';

void main() {
  test('loads defaults when nothing is saved', () async {
    final repository = PreferencesSettingsRepository(
      preferences: FakePreferencesService(),
    );

    final result = await repository.load();

    expect(result, isA<Ok<AppSettings>>());
    expect((result as Ok<AppSettings>).value, const AppSettings());
  });

  test('saved settings load back', () async {
    final repository = PreferencesSettingsRepository(
      preferences: FakePreferencesService(),
    );
    const settings = AppSettings(
      language: AppLanguage.en,
      yearEra: YearEra.gregorian,
      hideOnLaunch: true,
      showJournal: false,
      keepSlipImages: false,
      setupComplete: true,
    );

    await repository.save(settings);
    final result = await repository.load();

    expect((result as Ok<AppSettings>).value, settings);
  });

  test('falls back to defaults for unknown stored values', () async {
    final repository = PreferencesSettingsRepository(
      preferences: FakePreferencesService(
        values: {'settings.language': 'fr', 'settings.yearEra': 'lunar'},
      ),
    );

    final result = await repository.load();

    expect((result as Ok<AppSettings>).value, const AppSettings());
  });

  test('returns an error when storage fails', () async {
    final repository = PreferencesSettingsRepository(
      preferences: FakePreferencesService(error: Exception('disk')),
    );

    expect(await repository.load(), isA<Error<AppSettings>>());
    expect(await repository.save(const AppSettings()), isA<Error<void>>());
  });

  test('reports the first error when several reads fail', () async {
    final failure = Exception('disk');
    final repository = PreferencesSettingsRepository(
      preferences: FakePreferencesService(error: failure),
    );

    final result = await repository.load();

    expect((result as Error<AppSettings>).error, same(failure));
  });

  test('writes every setting under its own key', () async {
    final preferences = FakePreferencesService();
    final repository = PreferencesSettingsRepository(preferences: preferences);

    await repository.save(
      const AppSettings(language: AppLanguage.en, hideOnLaunch: true),
    );

    expect(preferences.values, {
      'settings.language': 'en',
      'settings.yearEra': 'buddhist',
    });
    expect(preferences.flags, {
      'settings.hideOnLaunch': true,
      'settings.showJournal': true,
      'settings.keepSlipImages': true,
      'settings.setupComplete': false,
    });
  });
}
