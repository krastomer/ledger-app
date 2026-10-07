part of 'setup_cubit.dart';

enum SetupStatus { idle, picking, ready, saving, done }

enum SetupError { unreadableFile, fileFailed, saveFailed }

@freezed
abstract class SetupState with _$SetupState {
  const factory SetupState({
    @Default(SetupStatus.idle) SetupStatus status,
    LedgerImportDraft? draft,
    SetupError? error,
    @Default(0) int unreadableCount,
  }) = _SetupState;
}
