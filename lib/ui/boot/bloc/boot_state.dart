part of 'boot_cubit.dart';

enum BootStatus { checking, ready, failed }

@freezed
abstract class BootState with _$BootState {
  const factory BootState({
    @Default(BootStatus.checking) BootStatus status,
    LedgerCheck? check,
  }) = _BootState;
}
