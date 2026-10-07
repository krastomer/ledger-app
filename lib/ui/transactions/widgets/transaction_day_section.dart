import 'package:flutter/material.dart';
import 'package:ledger_app/domain/models/transaction_day.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_dashed_line.dart';
import 'package:ledger_app/utils/date_format.dart';

import 'transaction_tile.dart';

class TransactionDaySection extends StatelessWidget {
  const TransactionDaySection({
    super.key,
    required this.day,
    required this.onOpen,
  });

  final TransactionDay day;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heading = formatDayHeading(day.date, context.localeName);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: Dimens.gapXS),
          child: SizedBox(
            height: 24,
            child: Row(
              spacing: Dimens.gapS,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    day.isToday ? '$heading · ${context.l10n.today}' : heading,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const Expanded(child: TuiDashedLine()),
              ],
            ),
          ),
        ),
        for (final transaction in day.transactions)
          TransactionTile(
            transaction: transaction,
            onTap: () => onOpen(transaction.id),
          ),
      ],
    );
  }
}
