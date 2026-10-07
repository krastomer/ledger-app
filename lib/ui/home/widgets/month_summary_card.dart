import 'package:flutter/material.dart';
import 'package:ledger_app/domain/models/category_total.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/themes/money_colors.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/ui/core/widgets/tui_bar.dart';
import 'package:ledger_app/ui/core/widgets/tui_dashed_line.dart';
import 'package:ledger_app/ui/core/widgets/tui_link_footer.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/utils/date_format.dart';
import 'package:ledger_app/utils/percent_format.dart';
import 'package:money2/money2.dart';

const _flowLabelWidth = 64.0;
const _nameWidth = 84.0;
const _shareWidth = 52.0;

class MonthSummaryCard extends StatelessWidget {
  const MonthSummaryCard({
    super.key,
    required this.month,
    required this.income,
    required this.expenses,
    required this.net,
    required this.topSpending,
    required this.amountsHidden,
    required this.onSeeReports,
  });

  final DateTime month;
  final Money income;
  final Money expenses;
  final Money net;
  final List<CategoryTotal> topSpending;
  final bool amountsHidden;
  final VoidCallback onSeeReports;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moneyColors = theme.moneyColors;
    final l10n = context.l10n;
    final scale = income > expenses ? income : expenses;
    return TuiPanel(
      title: formatMonthShortYear(month, context.localeName, context.yearEra),
      child: TuiLinkFooter(
        label: l10n.seeReports,
        onPressed: onSeeReports,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _FlowRow(
              label: l10n.income,
              amount: income,
              showPlus: true,
              hidden: amountsHidden,
              bar: TuiBar.share(income, scale),
              barColor: moneyColors.income,
            ),
            _FlowRow(
              label: l10n.expenses,
              amount: -expenses,
              hidden: amountsHidden,
              bar: TuiBar.share(expenses, scale),
              barColor: moneyColors.expense,
            ),
            _FlowRow(
              label: l10n.net,
              amount: net,
              showPlus: true,
              hidden: amountsHidden,
            ),
            if (topSpending.isNotEmpty) ...[
              _RuleHeading(label: l10n.topSpending),
              for (final category in topSpending)
                _SpendingRow(category: category, hidden: amountsHidden),
            ],
          ],
        ),
      ),
    );
  }
}

class _FlowRow extends StatelessWidget {
  const _FlowRow({
    required this.label,
    required this.amount,
    required this.hidden,
    this.showPlus = false,
    this.bar,
    this.barColor,
  });

  final String label;
  final Money amount;
  final bool hidden;
  final bool showPlus;
  final double? bar;
  final Color? barColor;

  @override
  Widget build(BuildContext context) {
    final bar = this.bar;
    return Row(
      spacing: Dimens.gapS,
      children: [
        SizedBox(
          width: _flowLabelWidth,
          child: Text(
            label.toLowerCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        SizedBox(
          width: Dimens.amountColumn,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerEnd,
            child: AmountText(amount, hidden: hidden, showPlus: showPlus),
          ),
        ),
        Expanded(
          child: bar == null
              ? const SizedBox.shrink()
              : TuiBar(fraction: bar, color: barColor),
        ),
      ],
    );
  }
}

class _RuleHeading extends StatelessWidget {
  const _RuleHeading({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.gapS, bottom: Dimens.gapXS),
      child: Row(
        spacing: Dimens.gapS,
        children: [
          const Expanded(child: TuiDashedLine()),
          Text(
            label.toLowerCase(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const Expanded(child: TuiDashedLine()),
        ],
      ),
    );
  }
}

class _SpendingRow extends StatelessWidget {
  const _SpendingRow({required this.category, required this.hidden});

  final CategoryTotal category;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    return Row(
      spacing: 6,
      children: [
        SizedBox(
          width: _nameWidth,
          child: Text(
            category.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(child: TuiBar(fraction: category.sharePerMille / 1000)),
        SizedBox(
          width: _shareWidth,
          child: Text(
            formatPerMille(category.sharePerMille),
            textAlign: TextAlign.end,
            style: TextStyle(color: muted),
          ),
        ),
        SizedBox(
          width: Dimens.amountColumn,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: AlignmentDirectional.centerEnd,
            child: AmountText(category.amount, hidden: hidden),
          ),
        ),
      ],
    );
  }
}
