import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/account_node.dart';

import '../../../testing/fixtures/ledger_fixtures.dart';

AccountNode node(
  String account,
  int satang, {
  int own = 0,
  List<AccountNode> children = const [],
}) => AccountNode(
  account: account,
  name: account.split(':').last,
  amount: thb(satang),
  ownAmount: thb(own),
  ownEntryCount: own == 0 ? 0 : 1,
  children: children,
);

void main() {
  test('lists children then own postings with shares of the total', () {
    final food = node(
      'Expenses:Food',
      10000,
      own: 2500,
      children: [
        node('Expenses:Food:Lunch', 5000, own: 5000),
        node('Expenses:Food:Coffee', 2500, own: 2500),
      ],
    );

    final allocations = food.allocations;

    expect(allocations.map((a) => (a.account, a.perMille)), [
      ('Expenses:Food:Lunch', 500),
      ('Expenses:Food:Coffee', 250),
      (null, 250),
    ]);
    expect(allocations.first.entryCount, 1);
  });

  test('skips refunds and empty children', () {
    final food = node(
      'Expenses:Food',
      3000,
      children: [
        node('Expenses:Food:Lunch', 3000, own: 3000),
        node('Expenses:Food:Refund', -500, own: -500),
      ],
    );

    expect(food.allocations.map((a) => a.name), ['Lunch']);
  });

  test('counts entries through the subtree', () {
    final food = node(
      'Expenses:Food',
      3000,
      children: [node('Expenses:Food:Lunch', 3000, own: 3000)],
    );

    expect(food.entryCount, 1);
    expect(food.hasChildren, isTrue);
  });
}
