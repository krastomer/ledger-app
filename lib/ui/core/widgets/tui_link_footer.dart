import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_cell.dart';

/// Ends a panel's content with a `label →` link on one tight line. The link
/// still gets a full tap target by reaching up over the end of [child], so
/// that part of [child] must not be interactive.
class TuiLinkFooter extends StatelessWidget {
  const TuiLinkFooter({
    super.key,
    required this.label,
    required this.onPressed,
    required this.child,
  });

  final String label;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final line = measureTuiCell(context).height;
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Dimens.gapXS + line),
          child: child,
        ),
        PositionedDirectional(
          end: 0,
          bottom: 0,
          height: math.max(Dimens.tapTarget, line),
          child: TuiButton(
            label: '$label →',
            padding: 0,
            alignment: AlignmentDirectional.bottomEnd,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
