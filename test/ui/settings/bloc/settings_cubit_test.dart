import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/app_language.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';

import '../../../../testing/fakes/fake_settings_repository.dart';

void main() {
  late FakeSettingsRepository repository;

  setUp(() => repository = FakeSettingsRepository());

  blocTest<SettingsCubit, SettingsState>(
    'changes and saves the language',
    build: () =>
        SettingsCubit(repository: repository, initial: const AppSettings()),
    act: (cubit) => cubit.setLanguage(AppLanguage.en),
    expect: () => [
      const SettingsState(settings: AppSettings(language: AppLanguage.en)),
    ],
    verify: (_) => expect(repository.saved.language, AppLanguage.en),
  );

  blocTest<SettingsCubit, SettingsState>(
    'changes and saves the year era',
    build: () =>
        SettingsCubit(repository: repository, initial: const AppSettings()),
    act: (cubit) => cubit.setYearEra(YearEra.gregorian),
    expect: () => [
      const SettingsState(settings: AppSettings(yearEra: YearEra.gregorian)),
    ],
    verify: (_) => expect(repository.saved.yearEra, YearEra.gregorian),
  );

  blocTest<SettingsCubit, SettingsState>(
    'does nothing when the value is unchanged',
    build: () =>
        SettingsCubit(repository: repository, initial: const AppSettings()),
    act: (cubit) => cubit.setLanguage(AppLanguage.th),
    expect: () => <SettingsState>[],
  );

  blocTest<SettingsCubit, SettingsState>(
    'reverts and reports an error when saving fails',
    build: () => SettingsCubit(
      repository: FakeSettingsRepository(error: Exception('disk')),
      initial: const AppSettings(),
    ),
    act: (cubit) => cubit.setLanguage(AppLanguage.en),
    expect: () => [
      const SettingsState(settings: AppSettings(language: AppLanguage.en)),
      const SettingsState(
        settings: AppSettings(),
        error: SettingsError.saveFailed,
      ),
    ],
  );

  blocTest<SettingsCubit, SettingsState>(
    'changes and saves the switches',
    build: () =>
        SettingsCubit(repository: repository, initial: const AppSettings()),
    act: (cubit) async {
      await cubit.setHideOnLaunch(true);
      await cubit.setShowZeroBalance(true);
      await cubit.setKeepSlipImages(false);
    },
    expect: () => [
      const SettingsState(settings: AppSettings(hideOnLaunch: true)),
      const SettingsState(
        settings: AppSettings(hideOnLaunch: true, showZeroBalance: true),
      ),
      const SettingsState(
        settings: AppSettings(
          hideOnLaunch: true,
          showZeroBalance: true,
          keepSlipImages: false,
        ),
      ),
    ],
    verify: (_) => expect(
      repository.saved,
      const AppSettings(
        hideOnLaunch: true,
        showZeroBalance: true,
        keepSlipImages: false,
      ),
    ),
  );
}
