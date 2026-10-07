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
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final small = theme.textTheme.bodySmall?.copyWith(
      color: scheme.onSurfaceVariant,
    );
    final (amount, color) = switch (transaction.kind) {
      TransactionKind.expense => (-transaction.amount, null),
      TransactionKind.income => (transaction.amount, theme.moneyColors.income),
      TransactionKind.transfer => (transaction.amount, null),
    };
    final time = transaction.time;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: Dimens.tapTarget),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          spacing: Dimens.gapS,
          children: [
            SizedBox(
              width: 12,
              child: transaction.isPending
                  ? Text(
                      '!',
                      semanticsLabel: l10n.filterPending,
                      style: TextStyle(
                        color: scheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : null,
            ),
            Text(
              time == null ? '--:--' : formatTime(time),
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${transaction.from} → ${transaction.to}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: small,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AmountText(
                  amount,
                  showPlus: transaction.kind == TransactionKind.income,
                  color: color,
                ),
                if (transaction.hasSlip)
                  Text(
                    '[slip]',
                    semanticsLabel: l10n.slipAttached,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
