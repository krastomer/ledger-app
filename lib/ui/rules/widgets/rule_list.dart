import 'package:flutter/material.dart';
import 'package:ledger_app/domain/models/category_rule.dart';
import 'package:ledger_app/domain/models/rule_issue.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/widgets/tui_dashed_line.dart';

class RuleList extends StatelessWidget {
  const RuleList({super.key, required this.rules, required this.issues});

  final List<CategoryRule> rules;
  final List<RuleIssue> issues;

  @override
  Widget build(BuildContext context) {
    final divider = TuiDashedLine(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (index, rule) in rules.indexed) ...[
          if (index > 0) divider,
          _RuleRow(number: index + 1, rule: rule),
        ],
        for (final (index, issue) in issues.indexed) ...[
          if (rules.isNotEmpty || index > 0) divider,
          _IssueRow(issue: issue),
        ],
      ],
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.number, required this.rule});

  final int number;
  final CategoryRule rule;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final muted = TextStyle(color: scheme.onSurfaceVariant);
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 52),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${number.toString().padLeft(2, '0')} ',
                    style: muted,
                  ),
                  TextSpan(text: '%${rule.field.name} '),
                  TextSpan(
                    text: rule.pattern,
                    style: TextStyle(color: scheme.tertiary),
                  ),
                ],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: '-> ', style: muted),
                  TextSpan(
                    text: rule.account,
                    style: TextStyle(color: scheme.primary),
                  ),
                ],
              ),
              style: theme.textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _IssueRow extends StatelessWidget {
  const _IssueRow({required this.issue});

  final RuleIssue issue;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '! ${l10n.rulesSkippedLine(issue.line)}',
              style: TextStyle(color: scheme.error),
            ),
            Text(
              issueReasonText(l10n, issue.reason),
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String issueReasonText(AppLocalizations l10n, RuleIssueReason reason) =>
    switch (reason) {
      RuleIssueReason.badRegex => l10n.rulesReasonBadRegex,
      RuleIssueReason.missingAccount => l10n.rulesReasonMissingAccount,
      RuleIssueReason.unknownField => l10n.rulesReasonUnknownField,
      RuleIssueReason.unknownDirective => l10n.rulesReasonUnknownDirective,
    };
