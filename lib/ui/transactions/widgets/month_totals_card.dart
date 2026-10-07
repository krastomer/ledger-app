import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/money_colors.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/ui/core/widgets/tui_dashed_line.dart';
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
    return Column(
      children: [
        const TuiDashedLine(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
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
                divided: true,
              ),
              _Stat(
                label: l10n.net,
                amount: net,
                showPlus: true,
                divided: true,
              ),
            ],
          ),
        ),
        const TuiDashedLine(),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.label,
    required this.amount,
    this.color,
    this.showPlus = false,
    this.divided = false,
  });

  final String label;
  final Money amount;
  final Color? color;
  final bool showPlus;
  final bool divided;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme.bodySmall;
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: divided
              ? Border(left: BorderSide(color: scheme.outlineVariant))
              : null,
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: divided ? 10 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toLowerCase(),
                style: style?.copyWith(color: scheme.onSurfaceVariant),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.centerStart,
                child: AmountText(
                  amount,
                  showPlus: showPlus,
                  color: color,
                  style: style,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
