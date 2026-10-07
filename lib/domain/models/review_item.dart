import 'package:freezed_annotation/freezed_annotation.dart';

import 'transaction_summary.dart';

part 'review_item.freezed.dart';

/// Why an entry is in the inbox, most urgent first.
enum ReviewReason { pending, duplicate, uncategorized }

@freezed
abstract class ReviewItem with _$ReviewItem {
  const factory ReviewItem({
    required ReviewReason reason,

    /// The entry to act on; for a duplicate, the later copy.
    required TransactionSummary transaction,

    /// For a duplicate, the earlier entry it repeats.
    String? duplicateOf,

    /// For an uncategorized entry, the account to replace and the
    /// accounts of the same kind it could move to.
    String? uncategorizedAccount,
    @Default([]) List<String> categoryChoices,
  }) = _ReviewItem;
}
