import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/utils/result.dart';

void main() {
  test('Ok carries its value and Error its exception', () {
    const Result<int> ok = Result.ok(3);
    final failure = Exception('no');
    final Result<int> error = Result.error(failure);

    expect((ok as Ok<int>).value, 3);
    expect((error as Error<int>).error, same(failure));
  });

  test('a switch over a result must handle both cases', () {
    String describe(Result<int> result) => switch (result) {
      Ok(:final value) => 'ok $value',
      Error(:final error) => 'error $error',
    };

    expect(describe(const Result.ok(1)), 'ok 1');
    expect(describe(Result.error(const FormatException('x'))), contains('x'));
  });
}
