/// An exact amount of money in minor units (satang for THB, cents for USD).
///
/// Never goes through `double`: [tryParse] reads digits straight into
/// minor units.
class Money {
  const Money(this.minorUnits, {this.currency = 'THB'});

  /// Amount in 1/100 of [currency]. Negative for refunds and discounts.
  final int minorUnits;

  /// ISO 4217 code, e.g. `THB`, `USD`.
  final String currency;

  static final _pattern = RegExp(
    r'^(-)?(\d{1,3}(?:,\d{3})+|\d+)(?:\.(\d{1,2}))?$',
  );

  /// Parses `1,234.5`, `-7.64` or `150` into minor units, or returns null
  /// when [text] isn't a plain amount with at most two decimals.
  static Money? tryParse(String text, {String currency = 'THB'}) {
    final match = _pattern.firstMatch(text.trim());
    if (match == null) return null;
    final whole = int.parse(match.group(2)!.replaceAll(',', ''));
    final fraction = int.parse((match.group(3) ?? '').padRight(2, '0'));
    final minorUnits = whole * 100 + fraction;
    return Money(
      match.group(1) == null ? minorUnits : -minorUnits,
      currency: currency,
    );
  }

  Money operator +(Money other) {
    assert(
      other.currency == currency,
      'cannot add $currency and ${other.currency}',
    );
    return Money(minorUnits + other.minorUnits, currency: currency);
  }

  @override
  bool operator ==(Object other) =>
      other is Money &&
      other.minorUnits == minorUnits &&
      other.currency == currency;

  @override
  int get hashCode => Object.hash(minorUnits, currency);

  /// Plain `123.45 THB` form for debugging and tests; format for display
  /// with `intl` at the UI edge instead.
  @override
  String toString() {
    final sign = minorUnits < 0 ? '-' : '';
    final abs = minorUnits.abs();
    final fraction = (abs % 100).toString().padLeft(2, '0');
    return '$sign${abs ~/ 100}.$fraction $currency';
  }
}
