import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';

/// How a value is written: `"text"` and `[a, b]` in green, `true` or `2` in
/// amber.
enum SettingValueKind { text, literal, list }

/// A `key = value` line, as in a config file. [label] becomes the key.
class SettingKeyValue extends StatelessWidget {
  const SettingKeyValue({
    super.key,
    required this.label,
    required this.value,
    this.kind = SettingValueKind.text,
  });

  final String label;
  final String value;
  final SettingValueKind kind;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isList = kind == SettingValueKind.list;
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: label.toLowerCase().replaceAll(' ', '_')),
          TextSpan(
            text: ' = ',
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          TextSpan(
            text: kind == SettingValueKind.text ? '"$value"' : value,
            style: TextStyle(
              color: kind == SettingValueKind.literal
                  ? scheme.primary
                  : scheme.tertiary,
            ),
          ),
        ],
      ),
      maxLines: isList ? 1 : null,
      overflow: isList ? TextOverflow.ellipsis : null,
    );
  }
}

/// A `# comment` line.
class SettingComment extends StatelessWidget {
  const SettingComment(this.text, {super.key, this.small = false});

  final String text;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      '# $text',
      style: (small ? theme.textTheme.bodySmall : theme.textTheme.bodyMedium)
          ?.copyWith(
            fontStyle: FontStyle.italic,
            color: theme.colorScheme.onSurfaceVariant,
          ),
    );
  }
}

/// A setting that opens a picker or another screen.
class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
    this.kind = SettingValueKind.text,
    this.hint,
  });

  final String label;
  final String value;
  final SettingValueKind kind;
  final VoidCallback onTap;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final hint = this.hint;
    return _TileFrame(
      onTap: onTap,
      trailing: Text(
        '>',
        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
      child: hint == null
          ? SettingKeyValue(label: label, value: value, kind: kind)
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingKeyValue(label: label, value: value, kind: kind),
                SettingComment(hint, small: true),
              ],
            ),
    );
  }
}

/// An on/off setting shown as `key = true [x]`.
class SettingsSwitchTile extends StatelessWidget {
  const SettingsSwitchTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.hint,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final hint = this.hint;
    return Semantics(
      toggled: value,
      child: _TileFrame(
        onTap: () => onChanged(!value),
        trailing: Text(
          value ? '[x]' : '[ ]',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingKeyValue(
              label: label,
              value: '$value',
              kind: SettingValueKind.literal,
            ),
            if (hint != null) SettingComment(hint, small: true),
          ],
        ),
      ),
    );
  }
}

/// A line with a `< button >` at the end, for one-off commands.
class SettingsActionTile extends StatelessWidget {
  const SettingsActionTile({
    super.key,
    required this.child,
    required this.actionLabel,
    required this.onPressed,
  });

  final Widget child;
  final String actionLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Dimens.gapS,
      children: [
        Expanded(child: child),
        TuiButton.action(label: actionLabel, onPressed: onPressed),
      ],
    );
  }
}

class _TileFrame extends StatelessWidget {
  const _TileFrame({
    required this.onTap,
    required this.trailing,
    required this.child,
  });

  final VoidCallback onTap;
  final Widget trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: Dimens.tapTarget),
        child: Row(
          spacing: Dimens.gapS,
          children: [
            Expanded(child: child),
            ExcludeSemantics(child: trailing),
          ],
        ),
      ),
    );
  }
}
