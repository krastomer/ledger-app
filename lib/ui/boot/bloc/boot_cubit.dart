import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/domain/models/ledger_check.dart';
import 'package:ledger_app/domain/use_cases/ledger_check_use_case.dart';
import 'package:ledger_app/utils/result.dart';

part 'boot_cubit.freezed.dart';
part 'boot_state.dart';

class BootCubit extends Cubit<BootState> {
  BootCubit({required this._ledgerCheck}) : super(const BootState());

  final LedgerCheckUseCase _ledgerCheck;

  Future<void> run() async {
    final result = await _ledgerCheck();
    if (isClosed) return;
    emit(switch (result) {
      Ok(:final value) => BootState(status: BootStatus.ready, check: value),
      Error() => const BootState(status: BootStatus.failed),
    });
  }
}
