import 'package:freezed_annotation/freezed_annotation.dart';

import 'category_rule.dart';
import 'rule_issue.dart';

part 'rule_set.freezed.dart';

@freezed
abstract class RuleSet with _$RuleSet {
  const factory RuleSet({
    required String fileName,
    required String text,
    required DateTime loadedAt,
    required List<CategoryRule> rules,
    required List<RuleIssue> issues,
  }) = _RuleSet;
}
