import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

part 'category_total.freezed.dart';

@freezed
abstract class CategoryTotal with _$CategoryTotal {
  const factory CategoryTotal({
    required String account,
    required String name,
    required Money amount,

    /// Share of the period's total in tenths of a percent (386 = 38.6%).
    required int sharePerMille,
  }) = _CategoryTotal;
}
