import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/widgets/tui_dashed_line.dart';

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
    final scheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          header: true,
          child: Text(
            '# ${title.toLowerCase()}',
            style: theme.textTheme.bodySmall?.copyWith(
              height: 22 / 12,
              fontStyle: FontStyle.italic,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
        for (final (index, child) in children.indexed) ...[
          if (index > 0) TuiDashedLine(color: scheme.surfaceContainerHigh),
          child,
        ],
      ],
    );
  }
}
