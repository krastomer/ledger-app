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
        constraints: const BoxConstraints(minHeight: Dimens.tapTarget),
        child: Row(
          spacing: Dimens.gapS,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: label.toLowerCase().replaceAll(' ', '_')),
                    TextSpan(
                      text: ' = ',
                      style: TextStyle(color: muted),
                    ),
                    TextSpan(
                      text: '"$value"',
                      style: TextStyle(color: theme.colorScheme.tertiary),
                    ),
                  ],
                ),
              ),
            ),
            ExcludeSemantics(
              child: Text('>', style: TextStyle(color: muted)),
            ),
          ],
        ),
      ),
    );
  }
}
