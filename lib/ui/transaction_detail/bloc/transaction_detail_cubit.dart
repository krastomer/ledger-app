import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/domain/models/transaction_detail.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/domain/use_cases/transaction_detail_use_case.dart';
import 'package:ledger_app/utils/result.dart';

part 'transaction_detail_cubit.freezed.dart';
part 'transaction_detail_state.dart';

class TransactionDetailCubit extends Cubit<TransactionDetailState> {
  TransactionDetailCubit({
    required this.id,
    required this._transactionDetail,
    required this._editTransaction,
  }) : super(const TransactionDetailState());

  final String id;
  final TransactionDetailUseCase _transactionDetail;
  final EditTransactionUseCase _editTransaction;

  Future<void> load() async {
    final result = await _transactionDetail(id);
    if (isClosed) return;
    emit(switch (result) {
      Ok(value: final detail?) => state.copyWith(
        status: TransactionDetailStatus.success,
        detail: detail,
        error: null,
      ),
      Ok() => state.copyWith(status: TransactionDetailStatus.notFound),
      Error() => state.copyWith(
        status: TransactionDetailStatus.failure,
        error: TransactionDetailError.loadFailed,
      ),
    });
  }

  Future<void> confirm() async {
    emit(state.copyWith(error: null));
    final result = await _editTransaction.markCleared(id);
    if (isClosed) return;
    if (result is Error<void>) {
      emit(state.copyWith(error: TransactionDetailError.saveFailed));
    } else {
      await load();
    }
  }

  Future<void> delete() async {
    emit(state.copyWith(error: null));
    final result = await _editTransaction.delete(id);
    if (isClosed) return;
    emit(
      result is Error<void>
          ? state.copyWith(error: TransactionDetailError.saveFailed)
          : state.copyWith(status: TransactionDetailStatus.deleted),
    );
  }
}
