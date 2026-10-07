part of 'accounts_cubit.dart';

enum AccountsStatus { initial, loading, success, failure }

enum AccountsError { loadFailed }

enum AccountsMode { balance, monthChange }

@freezed
abstract class AccountsState with _$AccountsState {
  const factory AccountsState({
    @Default(AccountsStatus.initial) AccountsStatus status,
    AccountsSummary? summary,
    @Default(AccountsMode.balance) AccountsMode mode,
    @Default({}) Set<String> expanded,
    AccountsError? error,
  }) = _AccountsState;
}
