import 'package:ledger_app/domain/models/category_rule.dart';
import 'package:ledger_app/domain/models/rule_field.dart';
import 'package:ledger_app/domain/models/rule_issue.dart';
import 'package:ledger_app/domain/models/rule_set.dart';

RuleSet ruleSet({
  String fileName = 'ledger.rules',
  List<CategoryRule>? rules,
  List<RuleIssue> issues = const [],
  DateTime? loadedAt,
}) => RuleSet(
  fileName: fileName,
  text: '',
  loadedAt: loadedAt ?? DateTime(2026, 10, 8, 9, 12),
  rules: rules ?? fixtureRules,
  issues: issues,
);

const fixtureRules = [
  CategoryRule(
    field: RuleField.payee,
    pattern: 'Sample Property',
    account: 'expenses:rent',
  ),
  CategoryRule(
    field: RuleField.payee,
    pattern: 'BTS|MRT|Grab',
    account: 'expenses:transport',
  ),
  CategoryRule(
    field: RuleField.memo,
    pattern: 'salary',
    account: 'income:salary',
  ),
];
