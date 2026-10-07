import 'package:flutter/material.dart';

class MoneyColors extends ThemeExtension<MoneyColors> {
  const MoneyColors({
    required this.income,
    required this.expense,
    required this.transfer,
  });

  static const dark = MoneyColors(
    income: Color(0xFF7BD88F),
    expense: Color(0xFFFF6B5E),
    transfer: Color(0xFFD9DDD3),
  );

  final Color income;
  final Color expense;
  final Color transfer;

  @override
  MoneyColors copyWith({Color? income, Color? expense, Color? transfer}) =>
      MoneyColors(
        income: income ?? this.income,
        expense: expense ?? this.expense,
        transfer: transfer ?? this.transfer,
      );

  @override
  MoneyColors lerp(MoneyColors? other, double t) {
    if (other == null) return this;
    return MoneyColors(
      income: Color.lerp(income, other.income, t) ?? income,
      expense: Color.lerp(expense, other.expense, t) ?? expense,
      transfer: Color.lerp(transfer, other.transfer, t) ?? transfer,
    );
  }
}

extension MoneyColorsX on ThemeData {
  MoneyColors get moneyColors => extension<MoneyColors>() ?? MoneyColors.dark;
}
