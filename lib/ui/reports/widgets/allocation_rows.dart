import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/utils/percent_format.dart';
import 'package:money2/money2.dart';

const _shareWidth = 64.0;
const _amountWidth = 104.0;

class AllocationHeader extends StatelessWidget {
  const AllocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final style = Theme.of(context).textTheme.labelSmall
        ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.cardPadding,
        vertical: Dimens.gapS,
      ),
      child: Row(
        spacing: Dimens.gapS,
        children: [
          Expanded(child: Text(l10n.allocationItem, style: style)),
          SizedBox(
            width: _shareWidth,
            child: Text(
              l10n.allocationShare,
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
          SizedBox(
            width: _amountWidth,
            child: Text(
              l10n.allocationAmount,
              textAlign: TextAlign.end,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}

class ParentAllocationRow extends StatelessWidget {
  const ParentAllocationRow({
    super.key,
    required this.label,
    required this.subtitle,
    required this.perMille,
    required this.amount,
    required this.onTap,
  });

  final String label;
  final String subtitle;
  final int? perMille;
  final Money amount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radiusM - 4),
        side: BorderSide(color: scheme.primary, width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.gapM,
            vertical: Dimens.gapM,
          ),
          child: _RowContent(
            leading: Icon(Icons.arrow_back, size: 20, color: scheme.primary),
            label: label,
            subtitle: subtitle,
            perMille: perMille,
            amount: amount,
            emphasis: true,
          ),
        ),
      ),
    );
  }
}

class AllocationRow extends StatelessWidget {
  const AllocationRow({
    super.key,
    required this.color,
    required this.label,
    required this.subtitle,
    required this.perMille,
    required this.amount,
    this.onTap,
  });

  final Color color;
  final String label;
  final String subtitle;
  final int? perMille;
  final Money amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final row = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.cardPadding,
        vertical: Dimens.gapM,
      ),
      child: _RowContent(
        leading: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        label: label,
        subtitle: subtitle,
        perMille: perMille,
        amount: amount,
        opensDetail: onTap != null,
      ),
    );
    return onTap == null ? row : InkWell(onTap: onTap, child: row);
  }
}

class _RowContent extends StatelessWidget {
  const _RowContent({
    required this.leading,
    required this.label,
    required this.subtitle,
    required this.perMille,
    required this.amount,
    this.emphasis = false,
    this.opensDetail = false,
  });

  final bool opensDetail;
  final Widget leading;
  final String label;
  final String subtitle;
  final int? perMille;
  final Money amount;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final share = perMille;
    return Row(
      spacing: Dimens.gapS,
      children: [
        Expanded(
          child: Row(
            spacing: Dimens.gapM,
            children: [
              SizedBox(width: 20, child: Center(child: leading)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: emphasis ? FontWeight.w600 : null,
                            ),
                          ),
                        ),
                        if (opensDetail)
                          Icon(
                            Icons.chevron_right,
                            size: 18,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                      ],
                    ),
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: _shareWidth,
          child: Text(
            share == null ? '' : formatPerMille(share),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
        ),
        SizedBox(
          width: _amountWidth,
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: AmountText(
              amount,
              showSymbol: false,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: emphasis ? FontWeight.w600 : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
