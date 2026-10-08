import 'package:freezed_annotation/freezed_annotation.dart';

part 'rule_issue.freezed.dart';

enum RuleIssueReason {
  badRegex,
  missingAccount,
  unknownField,
  unknownDirective,
}

@freezed
abstract class RuleIssue with _$RuleIssue {
  const factory RuleIssue({
    required int line,
    required RuleIssueReason reason,
  }) = _RuleIssue;
}
