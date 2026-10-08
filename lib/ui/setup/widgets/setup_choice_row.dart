import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';

class SetupChoiceRow extends StatelessWidget {
  const SetupChoiceRow({
    super.key,
    required this.label,
    required this.hint,
    required this.selected,
    required this.onTap,
    this.minHeight = 64,
  });

  final String label;
  final String hint;
  final bool selected;
  final VoidCallback onTap;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Semantics(
      inMutuallyExclusiveGroup: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight),
          child: Row(
            spacing: Dimens.gapS,
            children: [
              ExcludeSemantics(
                child: Text(
                  selected ? '>' : ' ',
                  style: TextStyle(color: scheme.primary),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label.toLowerCase(),
                      style: TextStyle(
                        color: selected ? scheme.primary : scheme.onSurface,
                      ),
                    ),
                    Text(
                      hint,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              ExcludeSemantics(
                child: Text(
                  selected ? '(*)' : '( )',
                  style: TextStyle(
                    color: selected ? scheme.primary : scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
