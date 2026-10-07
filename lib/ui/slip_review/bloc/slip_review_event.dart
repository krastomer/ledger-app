part of 'slip_review_bloc.dart';

sealed class SlipReviewEvent {
  const SlipReviewEvent();
}

final class SlipReviewStarted extends SlipReviewEvent {
  const SlipReviewStarted();
}

final class SlipSkipped extends SlipReviewEvent {
  const SlipSkipped();
}

final class SlipSaveRequested extends SlipReviewEvent {
  const SlipSaveRequested();
}

final class SlipDescriptionChanged extends SlipReviewEvent {
  const SlipDescriptionChanged(this.description);

  final String description;
}

final class SlipAccountChanged extends SlipReviewEvent {
  const SlipAccountChanged({required this.posting, required this.account});

  /// Index of the posting in the draft entry.
  final int posting;
  final String account;
}
