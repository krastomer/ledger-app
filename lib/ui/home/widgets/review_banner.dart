import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';

class ReviewBanner extends StatelessWidget {
  const ReviewBanner({super.key, required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Material(
      color: scheme.tertiaryContainer,
      borderRadius: BorderRadius.circular(Dimens.radiusM),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.gapL),
            child: Row(
              spacing: Dimens.gapM,
              children: [
                Icon(Icons.inbox_outlined, color: scheme.onTertiaryContainer),
                Expanded(
                  child: Text(
                    context.l10n.reviewBannerTitle(count),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: scheme.onTertiaryContainer,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right, color: scheme.onTertiaryContainer),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
