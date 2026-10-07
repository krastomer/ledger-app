import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';

enum _Kind { link, action, primary, chip }

/// Text-only terminal controls. Labels are shown in lower case.
///
/// - [TuiButton.new]: an amber link (`open →`), or a key hint (`[q] back`)
///   when [keyHint] is set.
/// - [TuiButton.action]: an ncurses button (`< try again >`).
/// - [TuiButton.primary]: a filled `< save >` button for the main action.
/// - [TuiButton.chip]: a bordered toggle that fills amber when selected.
class TuiButton extends StatelessWidget {
  const TuiButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.tooltip,
    this.keyHint,
    this.minWidth = 0,
    this.padding = 6,
    this.alignment,
  }) : selected = false,
       color = null,
       _kind = _Kind.link;

  const TuiButton.action({
    super.key,
    required this.label,
    required this.onPressed,
    this.tooltip,
    this.minWidth = 0,
    this.padding = 6,
    this.color,
  }) : selected = false,
       keyHint = null,
       alignment = null,
       _kind = _Kind.action;

  const TuiButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.tooltip,
    this.minWidth = 0,
    this.padding = 14,
    this.color,
  }) : selected = false,
       keyHint = null,
       alignment = null,
       _kind = _Kind.primary;

  const TuiButton.chip({
    super.key,
    required this.label,
    required this.selected,
    required this.onPressed,
    this.tooltip,
    this.minWidth = 0,
    this.padding = 10,
  }) : keyHint = null,
       alignment = null,
       color = null,
       _kind = _Kind.chip;

  final String label;
  final VoidCallback? onPressed;
  final String? tooltip;
  final String? keyHint;
  final bool selected;
  final double minWidth;
  final double padding;

  /// Where the label sits in the tap target; centered by default.
  final AlignmentGeometry? alignment;

  /// Text color of an action, or fill of a primary button.
  final Color? color;
  final _Kind _kind;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final keyHint = this.keyHint;
    final text = switch (_kind) {
      _Kind.action || _Kind.primary => '< ${label.toLowerCase()} >',
      _Kind.link || _Kind.chip => label.toLowerCase(),
    };
    final (
      Color foreground,
      Color? background,
      Color? border,
    ) = switch (_kind) {
      _Kind.chip when selected => (
        scheme.onPrimary,
        scheme.primary,
        scheme.primary,
      ),
      _Kind.chip => (scheme.onSurface, null, scheme.outlineVariant),
      _Kind.primary => (scheme.surface, color ?? scheme.primary, null),
      _Kind.link when keyHint != null => (scheme.onSurface, null, null),
      _Kind.action => (color ?? scheme.primary, null, null),
      _Kind.link => (scheme.primary, null, null),
    };
    final button = TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foreground,
        backgroundColor: background,
        disabledForegroundColor: scheme.outline,
        disabledBackgroundColor: background == null
            ? null
            : scheme.surfaceContainerHigh,
        minimumSize: Size(minWidth, Dimens.tapTarget),
        padding: EdgeInsets.symmetric(horizontal: padding),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: alignment,
        shape: RoundedRectangleBorder(
          side: border == null ? BorderSide.none : BorderSide(color: border),
        ),
        textStyle: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: selected || _kind == _Kind.primary
              ? FontWeight.w600
              : FontWeight.w400,
        ),
      ),
      child: keyHint == null
          ? Text(text, maxLines: 1, softWrap: false)
          : Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 6,
              children: [
                _Key(keyHint),
                Text(text, maxLines: 1, softWrap: false),
              ],
            ),
    );
    final semantic = Semantics(
      selected: _kind == _Kind.chip ? selected : null,
      child: button,
    );
    final tooltip = this.tooltip;
    return tooltip == null
        ? semantic
        : Tooltip(message: tooltip, child: semantic);
  }
}

class _Key extends StatelessWidget {
  const _Key(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ExcludeSemantics(
      child: ColoredBox(
        color: scheme.surfaceContainerHigh,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(label, style: TextStyle(color: scheme.primary)),
        ),
      ),
    );
  }
}
