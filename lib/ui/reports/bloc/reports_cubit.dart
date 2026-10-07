import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/domain/models/account_node.dart';
import 'package:ledger_app/domain/models/income_statement.dart';
import 'package:ledger_app/domain/use_cases/income_statement_use_case.dart';
import 'package:ledger_app/utils/result.dart';

part 'reports_cubit.freezed.dart';
part 'reports_state.dart';

class ReportsCubit extends Cubit<ReportsState> {
  ReportsCubit({required this._incomeStatement}) : super(const ReportsState()) {
    _changes = _incomeStatement.changes.listen((_) => load());
  }

  final IncomeStatementUseCase _incomeStatement;
  late final StreamSubscription<void> _changes;

  Future<void> load() => _load(state.statement?.month);

  Future<void> previousMonth() => _shiftMonth(-1);

  Future<void> nextMonth() => _shiftMonth(1);

  void showOverview() => emit(state.copyWith(side: null, drill: const []));

  void openSide(ReportSide side) =>
      emit(state.copyWith(side: side, drill: const []));

  void drillInto(String account) {
    if (state.side == null) return;
    emit(state.copyWith(drill: [...state.drill, account]));
  }

  void back() {
    if (state.drill.isNotEmpty) {
      emit(
        state.copyWith(drill: state.drill.sublist(0, state.drill.length - 1)),
      );
    } else if (state.side != null) {
      emit(state.copyWith(side: null));
    }
  }

  Future<void> _shiftMonth(int delta) {
    final current = state.statement;
    if (current == null ||
        (delta > 0 && current.isLatestMonth) ||
        (delta < 0 && current.isEarliestMonth)) {
      return Future.value();
    }
    return _load(
      DateTime(current.month.year, current.month.month + delta),
      resetLevel: true,
    );
  }

  Future<void> _load(DateTime? month, {bool resetLevel = false}) async {
    emit(state.copyWith(status: ReportsStatus.loading, error: null));
    final result = await _incomeStatement(month: month);
    if (isClosed) return;
    switch (result) {
      case Ok(:final value):
        final next = state.copyWith(
          status: ReportsStatus.success,
          statement: value,
        );
        emit(
          resetLevel || (next.side != null && next.trail.isEmpty)
              ? next.copyWith(side: null, drill: const [])
              : next,
        );
      case Error():
        emit(
          state.copyWith(
            status: ReportsStatus.failure,
            error: ReportsError.loadFailed,
          ),
        );
    }
  }

  @override
  Future<void> close() async {
    await _changes.cancel();
    return super.close();
  }
}
