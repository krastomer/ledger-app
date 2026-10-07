import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/domain/models/review_item.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/domain/use_cases/review_queue_use_case.dart';
import 'package:ledger_app/utils/result.dart';

part 'inbox_cubit.freezed.dart';
part 'inbox_state.dart';

class InboxCubit extends Cubit<InboxState> {
  InboxCubit({
    required this._reviewQueue,
    required this._editTransaction,
    required this._importSlip,
  }) : super(const InboxState()) {
    _changes = _reviewQueue.changes.listen((_) => load());
  }

  final ReviewQueueUseCase _reviewQueue;
  final EditTransactionUseCase _editTransaction;
  final ImportSlipUseCase _importSlip;
  late final StreamSubscription<void> _changes;

  Future<void> load() async {
    emit(state.copyWith(status: InboxStatus.loading, error: null));
    final result = await _reviewQueue();
    if (isClosed) return;
    switch (result) {
      case Ok(:final value):
        emit(state.copyWith(status: InboxStatus.success, items: value));
      case Error():
        emit(
          state.copyWith(
            status: InboxStatus.failure,
            error: InboxError.loadFailed,
          ),
        );
    }
  }

  Future<void> confirm(ReviewItem item) =>
      _resolve(item, _editTransaction.markCleared(item.transaction.id));

  Future<void> dropDuplicate(ReviewItem item) =>
      _resolve(item, _editTransaction.delete(item.transaction.id));

  Future<void> categorize(ReviewItem item, String account) {
    final from = item.uncategorizedAccount;
    if (from == null) return Future.value();
    return _resolve(
      item,
      _editTransaction.recategorize(
        item.transaction.id,
        from: from,
        to: account,
      ),
    );
  }

  /// Leaves a suspected duplicate as it is for this session.
  void keep(ReviewItem item) => emit(
    state.copyWith(
      kept: {...state.kept, item.transaction.id},
      resolved: [...state.resolved, item],
    ),
  );

  Future<void> pickSlips() async {
    final result = await _importSlip.pickImages();
    if (isClosed) return;
    switch (result) {
      case Ok(:final value) when value.isNotEmpty:
        emit(state.copyWith(picked: value, error: null));
        emit(state.copyWith(picked: null));
      case Ok():
        break;
      case Error():
        emit(state.copyWith(error: InboxError.pickFailed));
    }
  }

  Future<void> _resolve(ReviewItem item, Future<Result<void>> action) async {
    emit(state.copyWith(error: null));
    final result = await action;
    if (isClosed) return;
    emit(
      result is Error<void>
          ? state.copyWith(error: InboxError.actionFailed)
          : state.copyWith(resolved: [...state.resolved, item]),
    );
  }

  @override
  Future<void> close() async {
    await _changes.cancel();
    return super.close();
  }
}
