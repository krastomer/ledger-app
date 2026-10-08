import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/parsers/rules/rules_parser.dart';
import 'package:ledger_app/domain/models/category_rule.dart';
import 'package:ledger_app/domain/models/rule_field.dart';
import 'package:ledger_app/domain/models/rule_issue.dart';

void main() {
  const parser = RulesParser();

  test('reads a rule with its field, pattern and account', () {
    final parsed = parser.parse('''
if %payee BTS|MRT|Grab
  account2 expenses:transport
''');

    expect(parsed.issues, isEmpty);
    expect(parsed.rules, const [
      CategoryRule(
        field: RuleField.payee,
        pattern: 'BTS|MRT|Grab',
        account: 'expenses:transport',
      ),
    ]);
  });

  test('keeps the order of the file', () {
    final parsed = parser.parse('''
if %payee a
  account2 expenses:a
if %memo b
  account2 expenses:b
''');

    expect(parsed.rules.map((r) => r.account), ['expenses:a', 'expenses:b']);
    expect(parsed.rules.map((r) => r.field), [RuleField.payee, RuleField.memo]);
  });

  test('a pattern without a field matches any', () {
    final parsed = parser.parse('if salary\n  account2 income:salary');

    expect(parsed.rules.single.field, RuleField.any);
    expect(parsed.rules.single.pattern, 'salary');
  });

  test('ignores comments, blank lines and windows line endings', () {
    final parsed = parser.parse(
      '# ledger.rules\r\n\r\n; note\r\nif %memo rent\r\n  account2 expenses:rent\r\n',
    );

    expect(parsed.issues, isEmpty);
    expect(parsed.rules.single.account, 'expenses:rent');
  });

  test('keeps spaces inside an account name', () {
    final parsed = parser.parse('if x\n  account2 Expenses:Eating Out');

    expect(parsed.rules.single.account, 'Expenses:Eating Out');
  });

  group('skips what it cannot use', () {
    test('a pattern that is not a regex', () {
      final parsed = parser.parse('if %payee [abc\n  account2 expenses:a');

      expect(parsed.rules, isEmpty);
      expect(parsed.issues, const [
        RuleIssue(line: 1, reason: RuleIssueReason.badRegex),
      ]);
    });

    test('an empty pattern', () {
      final parsed = parser.parse('if %payee\n  account2 expenses:a');

      expect(parsed.issues.single.reason, RuleIssueReason.badRegex);
    });

    test('a field it does not know', () {
      final parsed = parser.parse('if %amount 100\n  account2 expenses:a');

      expect(parsed.rules, isEmpty);
      expect(parsed.issues, const [
        RuleIssue(line: 1, reason: RuleIssueReason.unknownField),
      ]);
    });

    test('a rule with no account line', () {
      final parsed = parser.parse('if %payee a\n\nif %payee b\n  account2 x');

      expect(parsed.rules.single.pattern, 'b');
      expect(parsed.issues, const [
        RuleIssue(line: 1, reason: RuleIssueReason.missingAccount),
      ]);
    });

    test('an account line with no account', () {
      final parsed = parser.parse('if %payee a\n  account2');

      expect(parsed.rules, isEmpty);
      expect(parsed.issues.map((i) => i.reason), [
        RuleIssueReason.missingAccount,
        RuleIssueReason.missingAccount,
      ]);
    });

    test('a directive outside a rule and one it does not support', () {
      final parsed = parser.parse('skip 1\nif %payee a\n  comment hi');

      expect(parsed.issues, const [
        RuleIssue(line: 1, reason: RuleIssueReason.unknownDirective),
        RuleIssue(line: 3, reason: RuleIssueReason.unknownDirective),
        RuleIssue(line: 2, reason: RuleIssueReason.missingAccount),
      ]);
    });

    test('the lines under a rule it skipped', () {
      final parsed = parser.parse(
        'if %nope x\n  account2 expenses:a\nif %payee b\n  account2 expenses:b',
      );

      expect(parsed.rules.map((r) => r.pattern), ['b']);
      expect(parsed.issues.length, 1);
    });
  });
}
