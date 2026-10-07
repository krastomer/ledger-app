import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/data/repositories/settings/settings_repository.dart';
import 'package:ledger_app/domain/models/app_language.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/utils/result.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required this._repository, required AppSettings initial})
    : super(SettingsState(settings: initial));

  final SettingsRepository _repository;

  Future<void> setLanguage(AppLanguage language) =>
      _save(state.settings.copyWith(language: language));

  Future<void> setYearEra(YearEra yearEra) =>
      _save(state.settings.copyWith(yearEra: yearEra));

  Future<void> setHideOnLaunch(bool value) =>
      _save(state.settings.copyWith(hideOnLaunch: value));

  Future<void> setShowJournal(bool value) =>
      _save(state.settings.copyWith(showJournal: value));

  Future<void> setKeepSlipImages(bool value) =>
      _save(state.settings.copyWith(keepSlipImages: value));

  Future<void> completeSetup() =>
      _save(state.settings.copyWith(setupComplete: true));

  Future<void> _save(AppSettings settings) async {
    final previous = state.settings;
    if (settings == previous) return;
    emit(state.copyWith(settings: settings, error: null));
    final result = await _repository.save(settings);
    if (isClosed) return;
    if (result is Error<void>) {
      emit(state.copyWith(settings: previous, error: SettingsError.saveFailed));
    }
  }
}
