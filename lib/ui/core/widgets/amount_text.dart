import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/themes/app_theme.dart';
import 'package:ledger_app/utils/money_format.dart';
import 'package:money2/money2.dart';

class AmountText extends StatelessWidget {
  const AmountText(
    this.amount, {
    super.key,
    this.hidden = false,
    this.showPlus = false,
    this.showSymbol = true,
    this.style,
    this.color,
  });

  final Money amount;
  final bool hidden;
  final bool showPlus;
  final bool showSymbol;
  final TextStyle? style;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final base = style ?? DefaultTextStyle.of(context).style;
    return Text(
      hidden
          ? hiddenAmount
          : formatMoney(amount, showPlus: showPlus, showSymbol: showSymbol),
      maxLines: 1,
      style: base.copyWith(
        color: color,
        fontFamily: AppTheme.monoFontFamily,
        fontFamilyFallback: const [AppTheme.fontFamily],
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }
}
