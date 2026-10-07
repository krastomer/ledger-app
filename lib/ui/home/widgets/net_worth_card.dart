import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
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
    final l10n = context.l10n;
    return TuiPanel(
      title: l10n.netWorth,
      trailing: netWorth.currency.isoCode,
      accent: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            button: true,
            hint: l10n.accountsTitle,
            child: InkWell(
              onTap: onTap,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: Dimens.tapTarget),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: AmountText(
                      netWorth,
                      hidden: amountsHidden,
                      style: theme.textTheme.displaySmall,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _Line(label: l10n.assets, amount: assets, hidden: amountsHidden),
          _Line(
            label: l10n.liabilities,
            amount: -liabilities,
            hidden: amountsHidden,
          ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({
    required this.label,
    required this.amount,
    required this.hidden,
  });

  final String label;
  final Money amount;
  final bool hidden;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Dimens.gapL,
      children: [
        Text(
          label.toLowerCase(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Expanded(
          child: AmountText(amount, hidden: hidden, textAlign: TextAlign.end),
        ),
      ],
    );
  }
}
