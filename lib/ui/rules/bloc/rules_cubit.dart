import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/data/repositories/rules/rules_repository.dart';
import 'package:ledger_app/domain/models/rule_set.dart';
import 'package:ledger_app/utils/result.dart';

part 'rules_cubit.freezed.dart';
part 'rules_state.dart';

class RulesCubit extends Cubit<RulesState> {
  RulesCubit({required this._repository}) : super(const RulesState());

  final RulesRepository _repository;

  Future<void> load() async {
    emit(state.copyWith(status: RulesStatus.loading, error: null));
    final result = await _repository.load();
    if (isClosed) return;
    emit(switch (result) {
      Ok(:final value) => state.copyWith(
        status: RulesStatus.idle,
        saved: value,
      ),
      Error() => state.copyWith(
        status: RulesStatus.idle,
        error: RulesError.loadFailed,
      ),
    });
  }

  Future<void> pickFile() async {
    emit(state.copyWith(status: RulesStatus.picking, error: null));
    final result = await _repository.pickFile();
    if (isClosed) return;
    emit(switch (result) {
      Ok(value: final picked?) => state.copyWith(
        status: RulesStatus.idle,
        draft: picked,
        error: picked.rules.isEmpty ? RulesError.noRules : null,
      ),
      Ok() => state.copyWith(status: RulesStatus.idle),
      Error() => state.copyWith(
        status: RulesStatus.idle,
        error: RulesError.fileFailed,
      ),
    });
  }

  Future<void> commit() async {
    final draft = state.draft;
    if (draft == null || draft.rules.isEmpty) return;
    emit(state.copyWith(status: RulesStatus.saving, error: null));
    final result = await _repository.save(draft);
    if (isClosed) return;
    emit(
      result is Error<void>
          ? state.copyWith(
              status: RulesStatus.idle,
              error: RulesError.saveFailed,
            )
          : state.copyWith(status: RulesStatus.done, saved: draft, draft: null),
    );
  }

  Future<void> replace() async {
    await pickFile();
    if (isClosed) return;
    if (state.error == null && state.draft != null) await commit();
  }
}
