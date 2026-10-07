import 'package:flutter/material.dart';
import 'package:ledger_app/domain/models/transaction_kind.dart';
import 'package:ledger_app/domain/models/transaction_summary.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/themes/money_colors.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_dashed_line.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/utils/date_format.dart';

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
    final l10n = context.l10n;
    return TuiPanel(
      title: l10n.recent,
      padding: const EdgeInsets.fromLTRB(
        Dimens.panelPadding,
        Dimens.gapS,
        Dimens.panelPadding,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (transactions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.gapS),
              child: Text(l10n.noTransactions),
            ),
          for (final (index, transaction) in transactions.indexed) ...[
            if (index > 0) const TuiDashedLine(),
            _TransactionRow(transaction: transaction, hidden: amountsHidden),
          ],
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TuiButton(
              label: '${l10n.seeAll} →',
              padding: 0,
              onPressed: onSeeAll,
            ),
          ),
        ],
      ),
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
    final scheme = theme.colorScheme;
    final (amount, color) = switch (transaction.kind) {
      TransactionKind.expense => (-transaction.amount, null),
      TransactionKind.income => (transaction.amount, theme.moneyColors.income),
      TransactionKind.transfer => (transaction.amount, null),
    };
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: Dimens.tapTarget),
      child: Row(
        spacing: Dimens.gapS,
        children: [
          Text(
            formatMonthDay(transaction.date),
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          Expanded(
            child: Text(
              transaction.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          AmountText(
            amount,
            hidden: hidden,
            showPlus: transaction.kind == TransactionKind.income,
            color: color,
          ),
          SizedBox(
            width: 10,
            child: transaction.isPending
                ? Text(
                    '!',
                    semanticsLabel: context.l10n.filterPending,
                    style: TextStyle(
                      color: scheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
