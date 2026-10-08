import 'package:ledger_app/domain/models/category_rule.dart';
import 'package:ledger_app/domain/models/rule_field.dart';
import 'package:ledger_app/domain/models/rule_issue.dart';

typedef ParsedRules = ({List<CategoryRule> rules, List<RuleIssue> issues});

class RulesParser {
  const RulesParser();

  static const _accountDirective = 'account2';

  ParsedRules parse(String text) {
    final rules = <CategoryRule>[];
    final issues = <RuleIssue>[];
    ({int line, RuleField field, String pattern})? open;
    String? account;
    var skipping = false;

    void close() {
      final block = open;
      if (block != null) {
        final target = account;
        if (target == null) {
          issues.add(
            RuleIssue(line: block.line, reason: RuleIssueReason.missingAccount),
          );
        } else {
          rules.add(
            CategoryRule(
              field: block.field,
              pattern: block.pattern,
              account: target,
            ),
          );
        }
      }
      open = null;
      account = null;
      skipping = false;
    }

    final lines = text.split(RegExp(r'\r?\n'));
    for (final (index, raw) in lines.indexed) {
      final line = index + 1;
      final trimmed = raw.trim();
      if (trimmed.isEmpty ||
          trimmed.startsWith('#') ||
          trimmed.startsWith(';')) {
        continue;
      }
      if (!raw.startsWith(RegExp(r'\s'))) {
        close();
        final matcher = _parseMatcher(trimmed);
        final field = matcher.field;
        final pattern = matcher.pattern;
        if (field != null && pattern != null) {
          open = (line: line, field: field, pattern: pattern);
        } else {
          skipping = true;
          final reason = matcher.reason;
          if (reason != null) issues.add(RuleIssue(line: line, reason: reason));
        }
      } else if (skipping) {
        continue;
      } else if (open != null && _isAccountLine(trimmed)) {
        final value = trimmed.substring(_accountDirective.length).trim();
        if (value.isEmpty) {
          issues.add(
            RuleIssue(line: line, reason: RuleIssueReason.missingAccount),
          );
        } else {
          account = value;
        }
      } else {
        issues.add(
          RuleIssue(line: line, reason: RuleIssueReason.unknownDirective),
        );
      }
    }
    close();
    return (rules: rules, issues: issues);
  }

  static bool _isAccountLine(String trimmed) =>
      trimmed == _accountDirective ||
      trimmed.startsWith(RegExp('$_accountDirective\\s'));

  static ({RuleField? field, String? pattern, RuleIssueReason? reason})
  _parseMatcher(String trimmed) {
    if (trimmed != 'if' && !trimmed.startsWith(RegExp(r'if\s'))) {
      return (
        field: null,
        pattern: null,
        reason: RuleIssueReason.unknownDirective,
      );
    }
    var rest = trimmed.substring(2).trim();
    var field = RuleField.any;
    if (rest.startsWith('%')) {
      final end = rest.indexOf(RegExp(r'\s'));
      final name = end < 0 ? rest.substring(1) : rest.substring(1, end);
      final named = RuleField.values.asNameMap()[name];
      if (named == null) {
        return (
          field: null,
          pattern: null,
          reason: RuleIssueReason.unknownField,
        );
      }
      field = named;
      rest = end < 0 ? '' : rest.substring(end).trim();
    }
    if (!_isValidRegex(rest)) {
      return (field: null, pattern: null, reason: RuleIssueReason.badRegex);
    }
    return (field: field, pattern: rest, reason: null);
  }

  static bool _isValidRegex(String pattern) {
    if (pattern.isEmpty) return false;
    try {
      RegExp(pattern);
      return true;
    } on FormatException {
      return false;
    }
  }
}
