import 'package:flutter/material.dart';

class MoneyColors extends ThemeExtension<MoneyColors> {
  const MoneyColors({
    required this.income,
    required this.expense,
    required this.spendingBar,
    required this.transfer,
    required this.saved,
    required this.expensePalette,
    required this.incomePalette,
  });

  static const light = MoneyColors(
    income: Color(0xFF1D5C9E),
    expense: Color(0xFFA04316),
    spendingBar: Color(0xFFC0673B),
    transfer: Color(0xFF45473F),
    saved: Color(0xFF2E5B4E),
    expensePalette: [
      Color(0xFFA04316),
      Color(0xFFE0946C),
      Color(0xFF7A5C1E),
      Color(0xFFD4AE52),
      Color(0xFF56687A),
      Color(0xFFA3B0BC),
    ],
    incomePalette: [
      Color(0xFF1D5C9E),
      Color(0xFF8DB4DE),
      Color(0xFF2F7A78),
      Color(0xFFA9CFCB),
      Color(0xFF5B5F97),
      Color(0xFFB9BBE0),
    ],
  );

  static const dark = MoneyColors(
    income: Color(0xFF9CC3F0),
    expense: Color(0xFFF0A77F),
    spendingBar: Color(0xFFD98A62),
    transfer: Color(0xFFC6C7BD),
    saved: Color(0xFF8FC9B4),
    expensePalette: [
      Color(0xFFF0A77F),
      Color(0xFFB8613A),
      Color(0xFFE0BE6E),
      Color(0xFF8A6A25),
      Color(0xFFA3B4C6),
      Color(0xFF5F7080),
    ],
    incomePalette: [
      Color(0xFF9CC3F0),
      Color(0xFF3F6FA6),
      Color(0xFF7CC4C1),
      Color(0xFF2F7A78),
      Color(0xFFB4B7EB),
      Color(0xFF5B5F97),
    ],
  );

  final Color income;
  final Color expense;
  final Color spendingBar;
  final Color transfer;
  final Color saved;
  final List<Color> expensePalette;
  final List<Color> incomePalette;

  @override
  MoneyColors copyWith({
    Color? income,
    Color? expense,
    Color? spendingBar,
    Color? transfer,
    Color? saved,
    List<Color>? expensePalette,
    List<Color>? incomePalette,
  }) => MoneyColors(
    income: income ?? this.income,
    expense: expense ?? this.expense,
    spendingBar: spendingBar ?? this.spendingBar,
    transfer: transfer ?? this.transfer,
    saved: saved ?? this.saved,
    expensePalette: expensePalette ?? this.expensePalette,
    incomePalette: incomePalette ?? this.incomePalette,
  );

  @override
  MoneyColors lerp(MoneyColors? other, double t) {
    if (other == null) return this;
    return MoneyColors(
      income: Color.lerp(income, other.income, t) ?? income,
      expense: Color.lerp(expense, other.expense, t) ?? expense,
      spendingBar: Color.lerp(spendingBar, other.spendingBar, t) ?? spendingBar,
      transfer: Color.lerp(transfer, other.transfer, t) ?? transfer,
      saved: Color.lerp(saved, other.saved, t) ?? saved,
      expensePalette: t < 0.5 ? expensePalette : other.expensePalette,
      incomePalette: t < 0.5 ? incomePalette : other.incomePalette,
    );
  }
}

extension MoneyColorsX on ThemeData {
  MoneyColors get moneyColors => extension<MoneyColors>() ?? MoneyColors.light;
}
