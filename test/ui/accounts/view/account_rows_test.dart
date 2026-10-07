import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/account_node.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/accounts_summary.dart';
import 'package:ledger_app/ui/accounts/bloc/accounts_cubit.dart';
import 'package:ledger_app/ui/accounts/view/account_rows.dart';

import '../../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  AccountNode node(String account, [List<AccountNode>? children]) =>
      AccountNode(
        account: account,
        name: account.split(':').last,
        amount: thb(100),
        ownAmount: thb(children == null ? 100 : 0),
        ownEntryCount: children == null ? 1 : 0,
        children: children ?? const [],
      );

  final assets = node('Assets', [
    node('Assets:Bank', [node('Assets:Bank:KBank'), node('Assets:Bank:SCB')]),
    node('Assets:Cash'),
  ]);
  final summary = AccountsSummary(
    asOf: fixtureToday,
    netWorth: thb(100),
    assets: thb(100),
    liabilities: thb(0),
    sections: [
      AccountSection(
        type: AccountType.asset,
        balance: [assets],
        monthChange: [],
      ),
      AccountSection(
        type: AccountType.expense,
        balance: [node('Expenses')],
        monthChange: [node('Expenses')],
      ),
    ],
  );

  test('draws tree lines for the open accounts', () {
    final panels = visibleAccountRows(summary, AccountsMode.balance, {
      'Assets',
      'Assets:Bank',
    });

    final rows = panels.balanceSheet;
    expect(rows.map((row) => row.node.name), [
      'Assets',
      'Bank',
      'KBank',
      'SCB',
      'Cash',
    ]);
    expect(rows.map((row) => row.guides), [
      <TreeGuide>[],
      [TreeGuide.tee],
      [TreeGuide.pipe, TreeGuide.tee],
      [TreeGuide.pipe, TreeGuide.elbow],
      [TreeGuide.elbow],
    ]);
  });

  test('puts income and expenses in their own panel', () {
    final panels = visibleAccountRows(summary, AccountsMode.balance, {});

    expect(panels.balanceSheet.map((row) => row.node.name), ['Assets']);
    expect(panels.incomeStatement.map((row) => row.node.name), ['Expenses']);
    expect(panels.incomeStatement.single.isSectionStart, isTrue);
  });
}
