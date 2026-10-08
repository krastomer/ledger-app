import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:money2/money2.dart';

import '../view/account_rows.dart';

const _toggleWidth = 36.0;

/// An hledger `bal` line: amount, tree lines, name, `[-]`/`[+]`. Rows stay
/// 22px tall on purpose (a dense tree, asked for by the user); the whole
/// row toggles so the target is wider than it is tall.
class AccountRow extends StatelessWidget {
  const AccountRow({
    super.key,
    required this.name,
    required this.amount,
    required this.guides,
    required this.hasChildren,
    required this.isExpanded,
    required this.onToggle,
  });

  final String name;
  final Money amount;
  final List<TreeGuide> guides;
  final bool hasChildren;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final weight = guides.isEmpty ? FontWeight.w600 : null;
    final row = SizedBox(
      height: Dimens.treeRowHeight,
      child: Row(
        children: [
          SizedBox(
            width: Dimens.amountColumn,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerEnd,
              child: AmountText(
                amount,
                color: amount.isNegative ? theme.colorScheme.error : null,
                style: TextStyle(fontWeight: weight),
              ),
            ),
          ),
          const SizedBox(width: 10),
          if (guides.isNotEmpty)
            CustomPaint(
              size: Size(
                guides.length * Dimens.treeIndent,
                Dimens.treeRowHeight,
              ),
              painter: _GuidesPainter(guides: guides, color: scheme.outline),
            ),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: weight),
            ),
          ),
          SizedBox(
            width: _toggleWidth,
            child: hasChildren
                ? Tooltip(
                    message: isExpanded
                        ? l10n.collapseAccount(name)
                        : l10n.expandAccount(name),
                    child: Text(
                      isExpanded ? '[-]' : '[+]',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: scheme.primary),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
    if (!hasChildren) return row;
    return Semantics(
      button: true,
      expanded: isExpanded,
      child: InkWell(onTap: onToggle, child: row),
    );
  }
}

class _GuidesPainter extends CustomPainter {
  const _GuidesPainter({required this.guides, required this.color});

  final List<TreeGuide> guides;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    final middle = size.height / 2;
    for (final (index, guide) in guides.indexed) {
      final x = index * Dimens.treeIndent + 6.5;
      final bottom = switch (guide) {
        TreeGuide.pipe || TreeGuide.tee => size.height,
        TreeGuide.elbow => middle,
        TreeGuide.blank => null,
      };
      if (bottom != null) {
        canvas.drawLine(Offset(x, 0), Offset(x, bottom), paint);
      }
      if (guide == TreeGuide.tee || guide == TreeGuide.elbow) {
        canvas.drawLine(Offset(x, middle), Offset(x + 10, middle), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_GuidesPainter old) =>
      old.color != color || !listEquals(old.guides, guides);
}
