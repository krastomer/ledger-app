import 'package:flutter/material.dart';

class MoneyColors extends ThemeExtension<MoneyColors> {
  const MoneyColors({
    required this.income,
    required this.expense,
    required this.spendingBar,
    required this.transfer,
  });

  static const light = MoneyColors(
    income: Color(0xFF1D5C9E),
    expense: Color(0xFFA04316),
    spendingBar: Color(0xFFC0673B),
    transfer: Color(0xFF45473F),
  );

  static const dark = MoneyColors(
    income: Color(0xFF9CC3F0),
    expense: Color(0xFFF0A77F),
    spendingBar: Color(0xFFD98A62),
    transfer: Color(0xFFC6C7BD),
  );

  final Color income;
  final Color expense;
  final Color spendingBar;
  final Color transfer;

  @override
  MoneyColors copyWith({
    Color? income,
    Color? expense,
    Color? spendingBar,
    Color? transfer,
  }) => MoneyColors(
    income: income ?? this.income,
    expense: expense ?? this.expense,
    spendingBar: spendingBar ?? this.spendingBar,
    transfer: transfer ?? this.transfer,
  );

  @override
  MoneyColors lerp(MoneyColors? other, double t) {
    if (other == null) return this;
    return MoneyColors(
      income: Color.lerp(income, other.income, t) ?? income,
      expense: Color.lerp(expense, other.expense, t) ?? expense,
      spendingBar: Color.lerp(spendingBar, other.spendingBar, t) ?? spendingBar,
      transfer: Color.lerp(transfer, other.transfer, t) ?? transfer,
    );
  }
}

extension MoneyColorsX on ThemeData {
  MoneyColors get moneyColors => extension<MoneyColors>() ?? MoneyColors.light;
}
