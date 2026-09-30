part of 'transactions_cubit.dart';

enum TransactionsStatus { initial, loading, success, failure }

enum TransactionsError { loadFailed }

@freezed
abstract class TransactionsState with _$TransactionsState {
  const factory TransactionsState({
    @Default(TransactionsStatus.initial) TransactionsStatus status,
    MonthTransactions? data,
    @Default(TransactionFilter()) TransactionFilter filter,
    TransactionsError? error,
  }) = _TransactionsState;
}
