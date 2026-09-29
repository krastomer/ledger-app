import 'package:flutter/material.dart';
import 'package:ledger_app/domain/models/category_total.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/themes/money_colors.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/ui/core/widgets/see_more_button.dart';
import 'package:ledger_app/utils/date_format.dart';
import 'package:money2/money2.dart';

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
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimens.cardPadding,
          Dimens.gapXS,
          Dimens.cardPadding,
          Dimens.cardPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    formatMonthName(month, context.localeName),
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                SeeMoreButton(label: l10n.seeReports, onPressed: onSeeReports),
              ],
            ),
            // The link's 48dp tap target already spaces the header.
            const SizedBox(height: Dimens.gapXS),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: Dimens.gapM,
              children: [
                Row(
                  spacing: Dimens.gapS,
                  children: [
                    _Stat(
                      label: l10n.income,
                      amount: income,
                      color: moneyColors.income,
                      hidden: amountsHidden,
                      showPlus: true,
                    ),
                    _Stat(
                      label: l10n.expenses,
                      amount: -expenses,
                      color: moneyColors.expense,
                      hidden: amountsHidden,
                    ),
                    _Stat(
                      label: l10n.net,
                      amount: net,
                      hidden: amountsHidden,
                      showPlus: true,
                    ),
                  ],
                ),
                if (topSpending.isNotEmpty) ...[
                  const Divider(height: 1),
                  Text(
                    l10n.topSpending,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  for (final category in topSpending)
                    _SpendingBar(category: category, hidden: amountsHidden),
                ],
              ],
            ),
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
    required this.hidden,
    this.color,
    this.showPlus = false,
  });

  final String label;
  final Money amount;
  final bool hidden;
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
              hidden: hidden,
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

class _SpendingBar extends StatelessWidget {
  const _SpendingBar({required this.category, required this.hidden});

  final CategoryTotal category;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: Dimens.gapXS,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(category.name, style: theme.textTheme.bodyMedium),
            ),
            AmountText(
              category.amount,
              hidden: hidden,
              showSymbol: false,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(Dimens.barHeight / 2),
          child: LinearProgressIndicator(
            value: category.sharePerMille / 1000,
            minHeight: Dimens.barHeight,
            color: theme.moneyColors.spendingBar,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }
}
