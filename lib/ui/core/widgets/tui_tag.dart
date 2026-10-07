import 'package:flutter/material.dart';

/// A short filled label, like `CONFIRM` on an inbox item.
class TuiTag extends StatelessWidget {
  const TuiTag(this.label, {super.key, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          label,
          maxLines: 1,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
