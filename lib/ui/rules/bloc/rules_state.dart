part of 'rules_cubit.dart';

enum RulesStatus { initial, loading, idle, picking, saving, done }

enum RulesError { loadFailed, fileFailed, noRules, saveFailed }

@freezed
abstract class RulesState with _$RulesState {
  const factory RulesState({
    @Default(RulesStatus.initial) RulesStatus status,
    RuleSet? saved,
    RuleSet? draft,
    RulesError? error,
  }) = _RulesState;
}
