import 'package:ledger_app/domain/models/account_node.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/accounts_summary.dart';

import '../bloc/accounts_cubit.dart';

/// One column of tree lines to the left of an account name.
enum TreeGuide { pipe, tee, elbow, blank }

class AccountRowData {
  const AccountRowData({
    required this.node,
    required this.guides,
    required this.type,
    required this.isSectionStart,
  });

  final AccountNode node;
  final List<TreeGuide> guides;
  final AccountType type;
  final bool isSectionStart;

  bool get isRoot => guides.isEmpty;
}

typedef AccountPanels = ({
  List<AccountRowData> balanceSheet,
  List<AccountRowData> incomeStatement,
});

AccountPanels visibleAccountRows(
  AccountsSummary summary,
  AccountsMode mode,
  Set<String> expanded,
) {
  final balanceSheet = <AccountRowData>[];
  final incomeStatement = <AccountRowData>[];
  for (final section in summary.sections) {
    final rows = switch (section.type) {
      AccountType.income || AccountType.expense => incomeStatement,
      AccountType.asset ||
      AccountType.liability ||
      AccountType.equity => balanceSheet,
    };
    final roots = switch (mode) {
      AccountsMode.balance => section.balance,
      AccountsMode.monthChange => section.monthChange,
    };
    void visit(
      AccountNode node,
      List<bool> ancestorsHaveMore, {
      required bool isLast,
      required bool first,
    }) {
      final depth = ancestorsHaveMore.length;
      rows.add(
        AccountRowData(
          node: node,
          guides: depth == 0
              ? const []
              : [
                  for (final more in ancestorsHaveMore.skip(1))
                    more ? TreeGuide.pipe : TreeGuide.blank,
                  isLast ? TreeGuide.elbow : TreeGuide.tee,
                ],
          type: section.type,
          isSectionStart: first,
        ),
      );
      if (!expanded.contains(node.account)) return;
      for (final (index, child) in node.children.indexed) {
        visit(
          child,
          [...ancestorsHaveMore, !isLast],
          isLast: index == node.children.length - 1,
          first: false,
        );
      }
    }

    for (final (index, root) in roots.indexed) {
      visit(root, const [], isLast: true, first: index == 0);
    }
  }
  return (balanceSheet: balanceSheet, incomeStatement: incomeStatement);
}
