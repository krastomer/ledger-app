import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/themes/money_colors.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:money2/money2.dart';

class MonthTotalsCard extends StatelessWidget {
  const MonthTotalsCard({
    super.key,
    required this.income,
    required this.expenses,
    required this.net,
  });

  final Money income;
  final Money expenses;
  final Money net;

  @override
  Widget build(BuildContext context) {
    final moneyColors = Theme.of(context).moneyColors;
    final l10n = context.l10n;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.gapL,
          vertical: Dimens.gapM,
        ),
        child: Row(
          spacing: Dimens.gapS,
          children: [
            _Stat(
              label: l10n.income,
              amount: income,
              color: moneyColors.income,
              showPlus: true,
            ),
            _Stat(
              label: l10n.expenses,
              amount: -expenses,
              color: moneyColors.expense,
            ),
            _Stat(label: l10n.net, amount: net, showPlus: true),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.label,
    required this.amount,
    this.color,
    this.showPlus = false,
  });

  final String label;
  final Money amount;
  final Color? color;
  final bool showPlus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: AmountText(
              amount,
              showPlus: showPlus,
              showSymbol: false,
              color: color,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
