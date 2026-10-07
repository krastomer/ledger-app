import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/utils/uuid.dart';

void main() {
  test('makes a version 7 UUID', () {
    expect(
      uuidV7(),
      matches(
        RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-7[0-9a-f]{3}-[89ab][0-9a-f]{3}-'
          r'[0-9a-f]{12}$',
        ),
      ),
    );
  });

  test('sorts by creation time', () {
    final earlier = uuidV7(now: DateTime.utc(2026, 9, 29));
    final later = uuidV7(now: DateTime.utc(2026, 9, 30));

    expect(earlier.compareTo(later), lessThan(0));
  });
}
