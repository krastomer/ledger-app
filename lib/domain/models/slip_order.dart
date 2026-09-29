import 'money.dart';

/// Details of a broker order confirmation (stock or gold).
class SlipOrder {
  const SlipOrder({
    required this.symbol,
    this.quantity,
    this.unit,
    this.price,
    this.foreignAmount,
    this.exchangeRate,
  });

  /// Ticker or product, e.g. `NVDA`, `MTS-GOLD`.
  final String symbol;

  /// Exact quantity as printed (`0.7295008`), kept as text so no digits
  /// are lost to floating point.
  final String? quantity;

  /// `shares` or `oz`.
  final String? unit;

  /// Executed price per [unit], usually in USD.
  final Money? price;

  /// Order value in the foreign currency (USD amount, or gold amount).
  final Money? foreignAmount;

  /// THB per 1 unit of [foreignAmount]'s currency, as printed (`32.72`).
  final String? exchangeRate;

  @override
  bool operator ==(Object other) =>
      other is SlipOrder &&
      other.symbol == symbol &&
      other.quantity == quantity &&
      other.unit == unit &&
      other.price == price &&
      other.foreignAmount == foreignAmount &&
      other.exchangeRate == exchangeRate;

  @override
  int get hashCode =>
      Object.hash(symbol, quantity, unit, price, foreignAmount, exchangeRate);

  @override
  String toString() =>
      'SlipOrder($symbol, $quantity $unit @ $price, $foreignAmount, '
      'rate $exchangeRate)';
}
