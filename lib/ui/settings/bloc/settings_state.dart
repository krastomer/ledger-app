part of 'settings_cubit.dart';

enum SettingsError { saveFailed }

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    required AppSettings settings,
    SettingsError? error,
  }) = _SettingsState;
}
