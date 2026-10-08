part of 'setup_scan_cubit.dart';

enum SetupScanPhase {
  starting,
  scanning,
  scanned,
  review,
  saving,
  done,
  failed,
}

enum SetupScanError { noAccess, listFailed, saveFailed }

@freezed
abstract class SetupScanState with _$SetupScanState {
  const factory SetupScanState({
    @Default(SetupScanPhase.starting) SetupScanPhase phase,
    @Default(0) int libraryCount,
    @Default(0) int toCheck,
    @Default(0) int checked,
    @Default([]) List<FoundSlip> found,
    @Default({}) Set<String> selected,
    SetupScanError? error,
  }) = _SetupScanState;

  const SetupScanState._();

  bool get inReview =>
      phase == SetupScanPhase.review ||
      phase == SetupScanPhase.saving ||
      phase == SetupScanPhase.done;
}
