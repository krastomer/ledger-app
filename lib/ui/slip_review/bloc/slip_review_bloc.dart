import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/domain/models/slip_draft.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/utils/result.dart';

part 'slip_review_bloc.freezed.dart';
part 'slip_review_event.dart';
part 'slip_review_state.dart';

/// Reads picked slip images one at a time; each is saved or skipped.
class SlipReviewBloc extends Bloc<SlipReviewEvent, SlipReviewState> {
  SlipReviewBloc({required List<String> imagePaths, required this._importSlip})
    : super(SlipReviewState(imagePaths: imagePaths)) {
    on<SlipReviewStarted>(
      (_, emit) => _read(emit, 0),
      transformer: droppable(),
    );
    on<SlipSkipped>(
      (_, emit) => _read(emit, state.index + 1),
      transformer: droppable(),
    );
    on<SlipSaveRequested>(_onSaveRequested, transformer: droppable());
    on<SlipDescriptionChanged>(_onDescriptionChanged);
    on<SlipAccountChanged>(_onAccountChanged);
  }

  final ImportSlipUseCase _importSlip;

  Future<void> _read(Emitter<SlipReviewState> emit, int index) async {
    if (index >= state.imagePaths.length) {
      emit(state.copyWith(status: SlipReviewStatus.finished, draft: null));
      return;
    }
    emit(
      state.copyWith(
        index: index,
        status: SlipReviewStatus.reading,
        draft: null,
        error: null,
      ),
    );
    final result = await _importSlip.read(state.imagePaths[index]);
    emit(switch (result) {
      Ok(:final value) => state.copyWith(
        status: SlipReviewStatus.ready,
        draft: value,
      ),
      Error() => state.copyWith(status: SlipReviewStatus.unreadable),
    });
  }

  Future<void> _onSaveRequested(
    SlipSaveRequested event,
    Emitter<SlipReviewState> emit,
  ) async {
    final transaction = state.draft?.transaction;
    if (!state.canSave || transaction == null) return;
    emit(state.copyWith(status: SlipReviewStatus.saving, error: null));
    final result = await _importSlip.save(transaction);
    if (result is Error<void>) {
      emit(
        state.copyWith(
          status: SlipReviewStatus.ready,
          error: SlipReviewError.saveFailed,
        ),
      );
      return;
    }
    emit(state.copyWith(savedCount: state.savedCount + 1));
    await _read(emit, state.index + 1);
  }

  void _onDescriptionChanged(
    SlipDescriptionChanged event,
    Emitter<SlipReviewState> emit,
  ) {
    final draft = state.draft;
    final transaction = draft?.transaction;
    final description = event.description.trim();
    if (draft == null || transaction == null || description.isEmpty) return;
    emit(
      state.copyWith(
        draft: draft.copyWith(
          transaction: transaction.copyWith(description: description),
        ),
      ),
    );
  }

  void _onAccountChanged(
    SlipAccountChanged event,
    Emitter<SlipReviewState> emit,
  ) {
    final draft = state.draft;
    final transaction = draft?.transaction;
    if (draft == null || transaction == null) return;
    emit(
      state.copyWith(
        draft: draft.copyWith(
          transaction: transaction.copyWith(
            postings: [
              for (final (index, posting) in transaction.postings.indexed)
                index == event.posting
                    ? posting.copyWith(account: event.account)
                    : posting,
            ],
          ),
        ),
      ),
    );
  }
}
