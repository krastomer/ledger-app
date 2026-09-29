import 'package:flutter/material.dart';
import 'package:ledger_app/domain/models/transaction_kind.dart';
import 'package:ledger_app/domain/models/transaction_summary.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/themes/money_colors.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/ui/core/widgets/see_more_button.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({
    super.key,
    required this.transactions,
    required this.amountsHidden,
    required this.onSeeAll,
  });

  final List<TransactionSummary> transactions;
  final bool amountsHidden;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const SizedBox(width: Dimens.gapXS),
            Expanded(
              child: Text(l10n.recent, style: theme.textTheme.titleMedium),
            ),
            SeeMoreButton(label: l10n.seeAll, onPressed: onSeeAll),
            const SizedBox(width: Dimens.gapXS),
          ],
        ),
        Card(
          child: transactions.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(Dimens.gapL),
                  child: Text(l10n.noTransactions),
                )
              : Column(
                  children: [
                    for (final (index, transaction)
                        in transactions.indexed) ...[
                      if (index > 0) const Divider(height: 1),
                      _TransactionRow(
                        transaction: transaction,
                        hidden: amountsHidden,
                      ),
                    ],
                  ],
                ),
        ),
      ],
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({required this.transaction, required this.hidden});

  final TransactionSummary transaction;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moneyColors = theme.moneyColors;
    final (amount, color) = switch (transaction.kind) {
      TransactionKind.expense => (-transaction.amount, moneyColors.expense),
      TransactionKind.income => (transaction.amount, moneyColors.income),
      TransactionKind.transfer => (transaction.amount, moneyColors.transfer),
    };
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 60),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.cardPadding,
          vertical: 10,
        ),
        child: Row(
          spacing: Dimens.gapM,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
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
            AmountText(
              amount,
              hidden: hidden,
              showPlus: transaction.kind == TransactionKind.income,
              color: color,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
