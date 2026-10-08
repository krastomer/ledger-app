import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';

class SetupChipChoice<T> extends StatelessWidget {
  const SetupChipChoice({
    super.key,
    required this.label,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final List<(T, String)> options;
  final T selected;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 52),
      child: Row(
        spacing: Dimens.gapS,
        children: [
          Expanded(
            child: Text(
              label.toLowerCase().replaceAll(' ', '_'),
              style: TextStyle(color: scheme.onSurface),
            ),
          ),
          Semantics(
            label: label,
            container: true,
            child: Row(
              spacing: Dimens.gapXS,
              children: [
                for (final (value, text) in options)
                  TuiButton.chip(
                    label: text,
                    selected: value == selected,
                    onPressed: () => onSelected(value),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
