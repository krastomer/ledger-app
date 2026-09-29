import 'package:money2/money2.dart';

const _withSymbol = 'S#,##0.00';
const _plain = '#,##0.00';
const _minus = '−';

const hiddenAmount = '••••••';

String formatMoney(
  Money amount, {
  bool showSymbol = true,
  bool showPlus = false,
}) {
  final magnitude = (amount.isNegative ? -amount : amount).format(
    showSymbol ? _withSymbol : _plain,
  );
  final sign = amount.isNegative
      ? _minus
      : showPlus && amount.isPositive
      ? '+'
      : '';
  return '$sign$magnitude';
}
