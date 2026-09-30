import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:money2/money2.dart';

class ReportTotal extends StatelessWidget {
  const ReportTotal({
    super.key,
    required this.title,
    required this.total,
    required this.showPlus,
    this.caption,
  });

  final String title;
  final Money total;
  final bool showPlus;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final caption = this.caption;
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.gapM),
      child: Column(
        children: [
          Text(
            caption == null ? title : '$title · $caption',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          AmountText(
            total,
            showPlus: showPlus,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
