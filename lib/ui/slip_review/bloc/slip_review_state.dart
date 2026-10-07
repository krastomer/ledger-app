part of 'slip_review_bloc.dart';

enum SlipReviewStatus { reading, ready, unreadable, saving, finished }

enum SlipReviewError { saveFailed }

@freezed
abstract class SlipReviewState with _$SlipReviewState {
  const factory SlipReviewState({
    required List<String> imagePaths,
    @Default(0) int index,
    @Default(SlipReviewStatus.reading) SlipReviewStatus status,
    SlipDraft? draft,
    @Default(0) int savedCount,
    SlipReviewError? error,
  }) = _SlipReviewState;

  const SlipReviewState._();

  /// Saving is blocked when there's no amount or the slip is already in
  /// the ledger.
  bool get canSave =>
      status == SlipReviewStatus.ready &&
      draft?.transaction != null &&
      draft?.duplicate == null;
}
