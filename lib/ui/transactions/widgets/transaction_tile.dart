import 'package:flutter/material.dart';
import 'package:ledger_app/domain/models/transaction_kind.dart';
import 'package:ledger_app/domain/models/transaction_summary.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/themes/money_colors.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/utils/date_format.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});

  final TransactionSummary transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moneyColors = theme.moneyColors;
    final (amount, color, icon) = switch (transaction.kind) {
      TransactionKind.expense => (
        -transaction.amount,
        moneyColors.expense,
        Icons.arrow_upward,
      ),
      TransactionKind.income => (
        transaction.amount,
        moneyColors.income,
        Icons.arrow_downward,
      ),
      TransactionKind.transfer => (
        transaction.amount,
        moneyColors.transfer,
        Icons.swap_horiz,
      ),
    };
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 64),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.cardPadding,
          vertical: 10,
        ),
        child: Row(
          spacing: Dimens.gapM,
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.12),
              foregroundColor: color,
              child: Icon(icon, size: 20),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 6,
                    children: [
                      Flexible(
                        child: Text(
                          transaction.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (transaction.hasSlip)
                        Icon(
                          Icons.receipt_long_outlined,
                          size: 14,
                          semanticLabel: context.l10n.slipAttached,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                    ],
                  ),
                  Text(
                    '${transaction.from} → ${transaction.to}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 2,
              children: [
                AmountText(
                  amount,
                  showPlus: transaction.kind == TransactionKind.income,
                  color: color,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _Meta(transaction: transaction),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta({required this.transaction});

  final TransactionSummary transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final time = transaction.time;
    final label = transaction.kind == TransactionKind.transfer
        ? l10n.transferLabel
        : time == null
        ? null
        : formatTime(time);
    if (transaction.isPending) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.gapS),
          child: Text(
            l10n.filterPending,
            style: theme.textTheme.labelSmall?.copyWith(
              color: scheme.onTertiaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
    if (label == null) return const SizedBox.shrink();
    return Text(
      label,
      style: theme.textTheme.bodySmall?.copyWith(
        color: scheme.onSurfaceVariant,
      ),
    );
  }
}
