import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/domain/models/home_summary.dart';
import 'package:ledger_app/domain/use_cases/home_summary_use_case.dart';
import 'package:ledger_app/utils/result.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this._homeSummary, bool amountsHidden = false})
    : super(HomeState(amountsHidden: amountsHidden)) {
    _changes = _homeSummary.changes.listen((_) => load());
  }

  final HomeSummaryUseCase _homeSummary;
  late final StreamSubscription<void> _changes;

  Future<void> load() async {
    emit(state.copyWith(status: HomeStatus.loading, error: null));
    final result = await _homeSummary();
    if (isClosed) return;
    switch (result) {
      case Ok(:final value):
        emit(state.copyWith(status: HomeStatus.success, summary: value));
      case Error():
        emit(
          state.copyWith(
            status: HomeStatus.failure,
            error: HomeError.loadFailed,
          ),
        );
    }
  }

  void setAmountsHidden(bool hidden) =>
      emit(state.copyWith(amountsHidden: hidden));

  void toggleAmountsHidden() =>
      emit(state.copyWith(amountsHidden: !state.amountsHidden));

  @override
  Future<void> close() async {
    await _changes.cancel();
    return super.close();
  }
}
