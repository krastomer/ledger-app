import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/ui/core/widgets/tui_bar.dart';
import 'package:ledger_app/utils/percent_format.dart';
import 'package:money2/money2.dart';

const _barWidth = 72.0;
const _shareWidth = 48.0;
const _gap = 6.0;

class AllocationHeader extends StatelessWidget {
  const AllocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final style = theme.textTheme.labelSmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return ExcludeSemantics(
      child: Row(
        spacing: _gap,
        children: [
          Expanded(
            child: Text(l10n.allocationItem.toLowerCase(), style: style),
          ),
          const SizedBox(width: _barWidth),
          SizedBox(
            width: _shareWidth,
            child: Text(
              l10n.allocationShare.toLowerCase(),
              textAlign: TextAlign.end,
              style: style,
            ),
          ),
          SizedBox(
            width: Dimens.amountColumn,
            child: Text(
              l10n.allocationAmount.toLowerCase(),
              textAlign: TextAlign.end,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}

/// The current level's own total, marked `..`; tapping it goes up.
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
    return Semantics(
      button: true,
      hint: context.l10n.back,
      child: InkWell(
        onTap: onTap,
        child: _RowContent(
          prefix: '.. ',
          label: label,
          subtitle: subtitle,
          perMille: perMille,
          amount: amount,
          isParent: true,
        ),
      ),
    );
  }
}

class AllocationRow extends StatelessWidget {
  const AllocationRow({
    super.key,
    required this.label,
    required this.subtitle,
    required this.perMille,
    required this.amount,
    this.onTap,
  });

  final String label;
  final String subtitle;
  final int? perMille;
  final Money amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final onTap = this.onTap;
    final row = _RowContent(
      label: onTap == null ? label : '$label/',
      subtitle: subtitle,
      perMille: perMille,
      amount: amount,
      showBar: true,
    );
    return onTap == null ? row : InkWell(onTap: onTap, child: row);
  }
}

class _RowContent extends StatelessWidget {
  const _RowContent({
    required this.label,
    required this.subtitle,
    required this.perMille,
    required this.amount,
    this.prefix,
    this.isParent = false,
    this.showBar = false,
  });

  final String? prefix;
  final String label;
  final String subtitle;
  final int? perMille;
  final Money amount;
  final bool isParent;
  final bool showBar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final share = perMille;
    final prefix = this.prefix;
    final weight = isParent ? FontWeight.w600 : null;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: Dimens.tapTarget),
      child: Row(
        spacing: _gap,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      if (prefix != null)
                        TextSpan(
                          text: prefix,
                          style: TextStyle(color: scheme.primary),
                        ),
                      TextSpan(text: label),
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: weight),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: _barWidth,
            child: showBar && share != null
                ? TuiBar(fraction: share / 1000)
                : null,
          ),
          SizedBox(
            width: _shareWidth,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                share == null ? '' : formatPerMille(share),
                maxLines: 1,
                softWrap: false,
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
            ),
          ),
          SizedBox(
            width: Dimens.amountColumn,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerEnd,
              child: AmountText(amount, style: TextStyle(fontWeight: weight)),
            ),
          ),
        ],
      ),
    );
  }
}
