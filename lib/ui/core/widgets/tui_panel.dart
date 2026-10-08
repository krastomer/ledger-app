import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';

const _labelHeight = 18.0;

/// A box with its title cut into the top border, like an ncurses window.
/// [openBottom] drops the bottom edge for a panel that runs off the screen.
class TuiPanel extends StatelessWidget {
  const TuiPanel({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.trailingColor,
    this.background,
    this.accent = false,
    this.borderColor,
    this.padding = const EdgeInsets.fromLTRB(
      Dimens.panelPadding,
      Dimens.panelPadding,
      Dimens.panelPadding,
      Dimens.gapS,
    ),
    this.openBottom = false,
  });

  final String title;
  final Widget child;
  final String? trailing;

  /// Highlights [trailing], e.g. a red `! pending`.
  final Color? trailingColor;

  /// Fills the inside of the border.
  final Color? background;

  /// Amber title for the screen's main panel.
  final bool accent;

  /// Also tints the title; used for the red inbox panel.
  final Color? borderColor;
  final EdgeInsetsGeometry padding;
  final bool openBottom;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final side = BorderSide(color: borderColor ?? scheme.outlineVariant);
    final labelStyle = theme.textTheme.labelMedium;
    final trailing = this.trailing;
    final labelHeight = MediaQuery.textScalerOf(context).scale(_labelHeight);
    final labelGrowth = math.max(0.0, labelHeight - _labelHeight);
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Padding(
          padding: EdgeInsets.only(top: labelHeight / 2),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: background,
              border: openBottom
                  ? Border(top: side, left: side, right: side)
                  : Border.fromBorderSide(side),
            ),
            child: Padding(
              padding: padding.add(EdgeInsets.only(top: labelGrowth / 2)),
              child: child,
            ),
          ),
        ),
        PositionedDirectional(
          top: 0,
          start: Dimens.gapS,
          end: Dimens.gapS,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: Dimens.gapS,
            children: [
              Flexible(
                child: _Label(
                  text: title.toLowerCase(),
                  isHeader: true,
                  style: labelStyle?.copyWith(
                    color:
                        borderColor ??
                        (accent ? scheme.primary : scheme.onSurfaceVariant),
                  ),
                ),
              ),
              if (trailing != null)
                Flexible(
                  child: _Label(
                    text: trailing,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: trailingColor ?? scheme.onSurfaceVariant,
                      fontWeight: trailingColor == null
                          ? null
                          : FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.text,
    required this.style,
    this.isHeader = false,
  });

  final String text;
  final TextStyle? style;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: isHeader,
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style?.copyWith(
              height: _labelHeight / (style?.fontSize ?? 12),
            ),
          ),
        ),
      ),
    );
  }
}
