import 'package:intl/intl.dart';
import 'package:money2/money2.dart';

const _withSymbol = 'S#,##0.00';
const _plain = '#,##0.00';
const _minus = '−';

const hiddenAmount = '••••••';

final _compact = NumberFormat.compact(locale: 'en');

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

/// Whole units in a short form for scales and legends: "300", "1.2k".
String formatCompactMoney(Money amount) {
  final unit = BigInt.from(10).pow(amount.currency.decimalDigits);
  return _compact.format((amount.minorUnits ~/ unit).toInt()).toLowerCase();
}
