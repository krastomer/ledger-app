import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

part 'allocation.freezed.dart';

@freezed
abstract class Allocation with _$Allocation {
  const factory Allocation({
    /// Null for the postings made directly on the parent account.
    required String? account,
    required String name,
    required Money amount,

    /// Share of the parent's total in tenths of a percent.
    required int perMille,
    required int entryCount,
    required int childCount,
  }) = _Allocation;
}
