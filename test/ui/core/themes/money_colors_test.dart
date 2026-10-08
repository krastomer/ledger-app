import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/ui/core/themes/app_theme.dart';
import 'package:ledger_app/ui/core/themes/money_colors.dart';

void main() {
  const other = MoneyColors(
    income: Color(0xFF000000),
    expense: Color(0xFFFFFFFF),
    transfer: Color(0xFF808080),
  );

  test('copyWith replaces only what is given', () {
    final changed = MoneyColors.dark.copyWith(income: other.income);

    expect(changed.income, other.income);
    expect(changed.expense, MoneyColors.dark.expense);
    expect(changed.transfer, MoneyColors.dark.transfer);
  });

  test('copyWith with nothing keeps every color', () {
    final same = MoneyColors.dark.copyWith();

    expect(same.income, MoneyColors.dark.income);
    expect(same.expense, MoneyColors.dark.expense);
    expect(same.transfer, MoneyColors.dark.transfer);
  });

  test('lerp blends each color', () {
    final start = MoneyColors.dark.lerp(other, 0);
    final end = MoneyColors.dark.lerp(other, 1);
    final middle = MoneyColors.dark.lerp(other, 0.5);

    expect(start.income, MoneyColors.dark.income);
    expect(end.expense, other.expense);
    expect(
      middle.transfer,
      Color.lerp(MoneyColors.dark.transfer, other.transfer, 0.5),
    );
  });

  test('lerp towards nothing stays put', () {
    expect(MoneyColors.dark.lerp(null, 0.5), same(MoneyColors.dark));
  });

  test('the theme carries the money colors, with a dark fallback', () {
    expect(AppTheme.dark.moneyColors.income, MoneyColors.dark.income);
    expect(ThemeData().moneyColors, MoneyColors.dark);
  });
}
