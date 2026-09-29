import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:money2/money2.dart';

class NetWorthCard extends StatelessWidget {
  const NetWorthCard({
    super.key,
    required this.netWorth,
    required this.assets,
    required this.liabilities,
    required this.amountsHidden,
    required this.onTap,
  });

  final Money netWorth;
  final Money assets;
  final Money liabilities;
  final bool amountsHidden;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final muted = scheme.primaryContainer;
    final small = theme.textTheme.bodySmall?.copyWith(color: muted);
    return Material(
      color: scheme.primary,
      borderRadius: BorderRadius.circular(Dimens.radiusL),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.gapL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Dimens.gapS,
            children: [
              Row(
                children: [
                  Expanded(child: Text(l10n.netWorth, style: small)),
                  Text(l10n.seeAccounts, style: small),
                  Icon(Icons.chevron_right, size: 18, color: muted),
                ],
              ),
              AmountText(
                netWorth,
                hidden: amountsHidden,
                color: scheme.onPrimary,
                style: theme.textTheme.displaySmall,
              ),
              Wrap(
                spacing: Dimens.gapXL,
                runSpacing: Dimens.gapXS,
                children: [
                  _LabeledAmount(
                    label: l10n.assets,
                    amount: assets,
                    hidden: amountsHidden,
                  ),
                  _LabeledAmount(
                    label: l10n.liabilities,
                    amount: liabilities,
                    hidden: amountsHidden,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LabeledAmount extends StatelessWidget {
  const _LabeledAmount({
    required this.label,
    required this.amount,
    required this.hidden,
  });

  final String label;
  final Money amount;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme.bodySmall;
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: Dimens.gapXS,
      children: [
        Text(label, style: style?.copyWith(color: scheme.primaryContainer)),
        AmountText(
          amount,
          hidden: hidden,
          color: scheme.onPrimary,
          style: style,
        ),
      ],
    );
  }
}
