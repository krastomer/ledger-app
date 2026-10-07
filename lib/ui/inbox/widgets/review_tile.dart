import 'package:flutter/material.dart';
import 'package:ledger_app/domain/models/review_item.dart';
import 'package:ledger_app/domain/models/transaction_kind.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/themes/money_colors.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_tag.dart';
import 'package:ledger_app/utils/date_format.dart';

/// One inbox entry: why it's here, what it is, and what to do about it.
/// A resolved item is greyed out and shows `[ ok ]` instead of buttons.
class ReviewTile extends StatelessWidget {
  const ReviewTile({
    super.key,
    required this.item,
    this.resolved = false,
    this.onOpen,
    this.onConfirm,
    this.onKeep,
    this.onDrop,
    this.onCategorize,
  });

  final ReviewItem item;
  final bool resolved;
  final VoidCallback? onOpen;
  final VoidCallback? onConfirm;
  final VoidCallback? onKeep;
  final VoidCallback? onDrop;
  final VoidCallback? onCategorize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final transaction = item.transaction;
    final (tag, tagColor) = switch (item.reason) {
      ReviewReason.pending => (l10n.reviewTagPending, scheme.error),
      ReviewReason.duplicate => (l10n.reviewTagDuplicate, scheme.primary),
      ReviewReason.uncategorized => (
        l10n.reviewTagUncategorized,
        scheme.onSurfaceVariant,
      ),
    };
    final isIncome = transaction.kind == TransactionKind.income;
    final small = theme.textTheme.bodySmall?.copyWith(
      color: scheme.onSurfaceVariant,
    );
    final buttons = switch (item.reason) {
      ReviewReason.pending => [
        _Secondary(label: l10n.openAction, onPressed: onOpen),
        _Primary(label: l10n.confirmAction, onPressed: onConfirm),
      ],
      ReviewReason.duplicate => [
        _Secondary(label: l10n.keepAction, onPressed: onKeep),
        _Primary(label: l10n.dropOneAction, onPressed: onDrop),
      ],
      ReviewReason.uncategorized => [
        _Primary(label: l10n.categorizeAction, onPressed: onCategorize),
      ],
    };
    return Opacity(
      opacity: resolved ? 0.45 : 1,
      child: Padding(
        padding: const EdgeInsets.only(top: Dimens.gapS, bottom: Dimens.gapXS),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              spacing: Dimens.gapS,
              children: [
                TuiTag(
                  tag,
                  color: resolved ? scheme.onSurfaceVariant : tagColor,
                ),
                Expanded(
                  child: Text(
                    transaction.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AmountText(
                  switch (transaction.kind) {
                    TransactionKind.expense => -transaction.amount,
                    _ => transaction.amount,
                  },
                  showPlus: isIncome,
                  color: isIncome ? theme.moneyColors.income : null,
                ),
              ],
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: Dimens.tapTarget),
              child: Row(
                spacing: Dimens.gapS,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${formatMonthDay(transaction.date)} · '
                          '${transaction.from} → ${transaction.to}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: small,
                        ),
                        if (item.reason == ReviewReason.duplicate && !resolved)
                          Text(
                            l10n.duplicateHint,
                            style: small?.copyWith(color: scheme.primary),
                          ),
                      ],
                    ),
                  ),
                  if (resolved)
                    Text('[ ok ]', style: TextStyle(color: scheme.tertiary))
                  else
                    ...buttons,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Secondary extends StatelessWidget {
  const _Secondary({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TuiButton.action(
      label: label,
      color: Theme.of(context).colorScheme.onSurface,
      onPressed: onPressed,
    );
  }
}

class _Primary extends StatelessWidget {
  const _Primary({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TuiButton.primary(
      label: label,
      padding: Dimens.gapS,
      color: Theme.of(context).colorScheme.onSurface,
      onPressed: onPressed,
    );
  }
}
