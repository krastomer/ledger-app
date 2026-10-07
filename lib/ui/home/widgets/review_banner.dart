import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';

class ReviewBanner extends StatelessWidget {
  const ReviewBanner({super.key, required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        child: TuiPanel(
          title: '! ${l10n.navInbox}',
          borderColor: scheme.error,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 34),
            child: Row(
              spacing: Dimens.gapM,
              children: [
                Text(
                  '$count',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: scheme.error,
                  ),
                ),
                Expanded(child: Text(l10n.itemsNeedReview(count))),
                Text(
                  '${l10n.openAction.toLowerCase()} →',
                  style: TextStyle(color: scheme.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
