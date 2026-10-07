import 'package:flutter/material.dart';
import 'package:ledger_app/domain/models/income_statement.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/themes/money_colors.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/utils/date_format.dart';
import 'package:ledger_app/utils/percent_format.dart';
import 'package:money2/money2.dart';

class IncomeStatementPanel extends StatelessWidget {
  const IncomeStatementPanel({super.key, required this.statement});

  final IncomeStatement statement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moneyColors = theme.moneyColors;
    final l10n = context.l10n;
    final expensesShare = statement.expensesPerMille;
    final saved = statement.savingsPerMille;
    return TuiPanel(
      title: l10n.incomeStatementTitle,
      trailing: formatMonthShortYear(
        statement.month,
        context.localeName,
        context.yearEra,
      ),
      accent: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Line(
            amount: statement.income,
            label: l10n.income,
            color: moneyColors.income,
            showPlus: true,
          ),
          _Line(
            amount: -statement.expenses,
            label: l10n.expenses,
            color: moneyColors.expense,
            note: expensesShare == null
                ? null
                : l10n.shareOfParent(
                    formatPerMille(expensesShare),
                    l10n.income,
                  ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: Dimens.gapXS),
            child: SizedBox(width: Dimens.amountColumn, child: Divider()),
          ),
          _Line(
            amount: statement.net,
            label: l10n.netLabel,
            showPlus: true,
            isTotal: true,
            note: saved == null
                ? null
                : l10n.savedPercent(formatPerMille(saved)),
          ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    required this.amount,
    required this.label,
    this.color,
    this.showPlus = false,
    this.isTotal = false,
    this.note,
  });

  final Money amount;
  final String label;
  final Color? color;
  final bool showPlus;
  final bool isTotal;
  final String? note;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weight = isTotal ? FontWeight.w600 : null;
    final note = this.note;
    return Row(
      spacing: 10,
      children: [
        SizedBox(
          width: Dimens.amountColumn,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerEnd,
            child: AmountText(
              amount,
              showPlus: showPlus,
              color: color,
              style: TextStyle(fontWeight: weight),
            ),
          ),
        ),
        Text(label.toLowerCase(), style: TextStyle(fontWeight: weight)),
        if (note != null)
          Expanded(
            child: Text(
              note,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }
}
