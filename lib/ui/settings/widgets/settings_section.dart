import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: Dimens.gapS,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.gapXS,
            Dimens.gapS,
            Dimens.gapXS,
            0,
          ),
          child: Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Card(
          child: Column(
            children: [
              for (final (index, child) in children.indexed) ...[
                if (index > 0) const Divider(),
                child,
              ],
            ],
          ),
        ),
      ],
    );
  }
}
