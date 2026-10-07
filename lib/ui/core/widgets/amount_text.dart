import 'package:flutter/material.dart';
import 'package:ledger_app/utils/money_format.dart';
import 'package:money2/money2.dart';

class AmountText extends StatelessWidget {
  const AmountText(
    this.amount, {
    super.key,
    this.hidden = false,
    this.showPlus = false,
    this.showSymbol = false,
    this.style,
    this.color,
    this.textAlign,
  });

  final Money amount;
  final bool hidden;
  final bool showPlus;
  final bool showSymbol;
  final TextStyle? style;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final base = style ?? DefaultTextStyle.of(context).style;
    return Text(
      hidden
          ? hiddenAmount
          : formatMoney(amount, showPlus: showPlus, showSymbol: showSymbol),
      maxLines: 1,
      softWrap: false,
      textAlign: textAlign,
      style: base.copyWith(
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
  }
}
