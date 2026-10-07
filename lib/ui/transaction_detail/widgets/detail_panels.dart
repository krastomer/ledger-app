import 'package:flutter/material.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/transaction_kind.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/domain/models/transaction_summary.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/themes/money_colors.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/utils/date_format.dart';
import 'package:ledger_app/utils/journal_format.dart';

/// Date, description, amount and status of one entry.
class EntryHeaderPanel extends StatelessWidget {
  const EntryHeaderPanel({
    super.key,
    required this.transaction,
    required this.summary,
  });

  final LedgerTransaction transaction;
  final TransactionSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final muted = TextStyle(color: scheme.onSurfaceVariant);
    final time = transaction.time;
    final code = transaction.code;
    final kind = switch (summary.kind) {
      TransactionKind.expense => l10n.kindExpense,
      TransactionKind.income => l10n.kindIncome,
      TransactionKind.transfer => l10n.kindTransfer,
    };
    final (status, statusColor) = switch (transaction.status) {
      TransactionStatus.pending => (
        '! ${l10n.filterPending.toLowerCase()}',
        scheme.error,
      ),
      TransactionStatus.cleared => ('* ${l10n.statusCleared}', null),
      TransactionStatus.unmarked => (null, null),
    };
    return TuiPanel(
      title: l10n.transactionTitle,
      accent: true,
      trailing: status,
      trailingColor: statusColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            [
              formatIsoDate(transaction.date),
              if (time != null) formatTime(time),
              '·',
              formatWeekdayShort(transaction.date, context.localeName),
              '·',
              kind,
            ].join(' '),
            style: muted,
          ),
          const SizedBox(height: 2),
          Text(transaction.description, style: theme.textTheme.titleLarge),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            spacing: Dimens.gapS,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: AmountText(
                    switch (summary.kind) {
                      TransactionKind.expense => -summary.amount,
                      _ => summary.amount,
                    },
                    showPlus: summary.kind == TransactionKind.income,
                    color: summary.kind == TransactionKind.income
                        ? theme.moneyColors.income
                        : null,
                    style: theme.textTheme.displaySmall,
                  ),
                ),
              ),
              Text(summary.amount.currency.isoCode, style: muted),
            ],
          ),
          if (code != null)
            Text(
              l10n.codeLabel(code),
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
        ],
      ),
    );
  }
}

/// Every posting, and whether they balance.
class PostingsPanel extends StatelessWidget {
  const PostingsPanel({super.key, required this.transaction});

  final LedgerTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    final balanced = transaction.isBalanced;
    return TuiPanel(
      title: l10n.postingsTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 2,
        children: [
          for (final posting in transaction.postings)
            Row(
              spacing: Dimens.gapM,
              children: [
                Expanded(
                  child: Text(
                    posting.account,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AmountText(posting.amount),
              ],
            ),
          const SizedBox(height: Dimens.gapXS),
          Divider(height: 1, color: scheme.outlineVariant),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                balanced ? '✓ ${l10n.balanced}' : '! ${l10n.notBalanced}',
                style: TextStyle(
                  color: balanced ? scheme.tertiary : scheme.error,
                ),
              ),
              if (balanced) const Text('0'),
            ],
          ),
        ],
      ),
    );
  }
}

/// The slip reference the entry was saved from.
class SlipRefPanel extends StatelessWidget {
  const SlipRefPanel({super.key, required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TuiPanel(
      title: l10n.slipTitle,
      child: Row(
        spacing: Dimens.gapM,
        children: [
          SizedBox(
            width: 56,
            child: Text(
              l10n.refLabel,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(child: SelectableText(code)),
        ],
      ),
    );
  }
}

/// The entry as journal text.
class JournalPanel extends StatelessWidget {
  const JournalPanel({super.key, required this.transaction});

  final LedgerTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TuiPanel(
      title: context.l10n.journalEntryTitle,
      background: theme.colorScheme.surfaceContainerLow,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          formatJournalEntry(transaction),
          softWrap: false,
          style: theme.textTheme.bodySmall,
        ),
      ),
    );
  }
}
