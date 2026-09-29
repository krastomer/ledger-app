import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 56),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.gapL,
            Dimens.gapS,
            Dimens.gapM,
            Dimens.gapS,
          ),
          child: Row(
            spacing: Dimens.gapS,
            children: [
              Expanded(child: Text(label, style: theme.textTheme.bodyLarge)),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(color: muted),
              ),
              Icon(Icons.chevron_right, size: 18, color: muted),
            ],
          ),
        ),
      ),
    );
  }
}
