import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/domain/models/month_transactions.dart';
import 'package:ledger_app/domain/models/transaction_filter.dart';
import 'package:ledger_app/domain/use_cases/month_transactions_use_case.dart';
import 'package:ledger_app/utils/result.dart';

part 'transactions_cubit.freezed.dart';
part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit({required this._monthTransactions})
    : super(const TransactionsState());

  final MonthTransactionsUseCase _monthTransactions;
  int _requestId = 0;

  Future<void> load() => _load(state.data?.month);

  Future<void> previousMonth() => _shiftMonth(-1);

  Future<void> nextMonth() => _shiftMonth(1);

  Future<void> setQuery(String query) =>
      _setFilter(state.filter.copyWith(query: query));

  Future<void> togglePendingOnly() =>
      _setFilter(state.filter.copyWith(pendingOnly: !state.filter.pendingOnly));

  Future<void> toggleWithSlipOnly() => _setFilter(
    state.filter.copyWith(withSlipOnly: !state.filter.withSlipOnly),
  );

  Future<void> _setFilter(TransactionFilter filter) {
    emit(state.copyWith(filter: filter));
    return load();
  }

  Future<void> _shiftMonth(int delta) {
    final current = state.data;
    if (current == null ||
        (delta > 0 && current.isLatestMonth) ||
        (delta < 0 && current.isEarliestMonth)) {
      return Future.value();
    }
    return _load(DateTime(current.month.year, current.month.month + delta));
  }

  Future<void> _load(DateTime? month) async {
    final requestId = ++_requestId;
    emit(state.copyWith(status: TransactionsStatus.loading, error: null));
    final result = await _monthTransactions(month: month, filter: state.filter);
    if (isClosed || requestId != _requestId) return;
    switch (result) {
      case Ok(:final value):
        emit(state.copyWith(status: TransactionsStatus.success, data: value));
      case Error():
        emit(
          state.copyWith(
            status: TransactionsStatus.failure,
            error: TransactionsError.loadFailed,
          ),
        );
    }
  }
}
