part of 'transaction_detail_cubit.dart';

enum TransactionDetailStatus { loading, success, notFound, failure, deleted }

enum TransactionDetailError { loadFailed, saveFailed }

@freezed
abstract class TransactionDetailState with _$TransactionDetailState {
  const factory TransactionDetailState({
    @Default(TransactionDetailStatus.loading) TransactionDetailStatus status,
    TransactionDetail? detail,
    TransactionDetailError? error,
  }) = _TransactionDetailState;
}
