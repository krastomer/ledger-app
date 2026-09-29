part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

enum HomeError { loadFailed }

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(HomeStatus.initial) HomeStatus status,
    HomeSummary? summary,
    @Default(false) bool amountsHidden,
    HomeError? error,
  }) = _HomeState;
}
