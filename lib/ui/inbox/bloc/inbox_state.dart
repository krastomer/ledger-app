part of 'inbox_cubit.dart';

enum InboxStatus { initial, loading, success, failure }

enum InboxError { loadFailed, actionFailed, pickFailed }

@freezed
abstract class InboxState with _$InboxState {
  const factory InboxState({
    @Default(InboxStatus.initial) InboxStatus status,

    /// Null until the first load.
    List<ReviewItem>? items,

    /// Items handled this session, shown greyed out under the open ones.
    @Default([]) List<ReviewItem> resolved,

    /// Suspected duplicates the user chose to keep.
    @Default({}) Set<String> kept,

    /// Slip images just picked; the view opens the review with them.
    List<String>? picked,
    InboxError? error,
  }) = _InboxState;

  const InboxState._();

  List<ReviewItem> get openItems => [
    for (final item in items ?? const <ReviewItem>[])
      if (!kept.contains(item.transaction.id)) item,
  ];
}
