import 'package:freezed_annotation/freezed_annotation.dart';

import 'rule_field.dart';

part 'category_rule.freezed.dart';

@freezed
abstract class CategoryRule with _$CategoryRule {
  const factory CategoryRule({
    required RuleField field,
    required String pattern,
    required String account,
  }) = _CategoryRule;
}
