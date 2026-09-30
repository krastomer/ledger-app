import 'package:flutter/material.dart';
import 'package:ledger_app/domain/models/transaction_day.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/utils/date_format.dart';

import 'transaction_tile.dart';

class TransactionDaySection extends StatelessWidget {
  const TransactionDaySection({super.key, required this.day});

  final TransactionDay day;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final heading = formatDayHeading(day.date, context.localeName);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            Dimens.gapXS,
            Dimens.gapL,
            Dimens.gapXS,
            Dimens.gapS,
          ),
          child: Text(
            day.isToday ? '$heading · ${context.l10n.today}' : heading,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (final (index, transaction) in day.transactions.indexed) ...[
                if (index > 0) const Divider(height: 1),
                TransactionTile(transaction: transaction),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
