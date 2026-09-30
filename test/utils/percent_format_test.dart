import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/utils/percent_format.dart';

void main() {
  test('formats tenths of a percent', () {
    expect(formatPerMille(386), '38.6%');
    expect(formatPerMille(1000), '100.0%');
    expect(formatPerMille(5), '0.5%');
  });
}
