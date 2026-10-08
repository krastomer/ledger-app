import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/routing/routes.dart';

void main() {
  test('builds the path of one entry from its id', () {
    expect(Routes.transactionPath('abc-123'), '/transaction/abc-123');
  });

  test('the entry route takes the same shape as its path', () {
    expect(Routes.transaction, '/transaction/:id');
    expect(
      Routes.transaction.replaceFirst(':id', 'x'),
      Routes.transactionPath('x'),
    );
  });
}
