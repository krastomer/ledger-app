import 'package:money2/money2.dart';

import 'account_node.dart';
import 'ledger_book.dart';
import 'posting.dart';

class AccountTreeBuilder {
  final _root = _Draft('', '');

  void add(Posting posting, {bool negate = false}) {
    var node = _root;
    for (final segment in posting.account.split(accountSeparator)) {
      final parent = node;
      node = parent.children.putIfAbsent(
        segment,
        () => _Draft(
          parent.account.isEmpty
              ? segment
              : '${parent.account}$accountSeparator$segment',
          segment,
        ),
      );
    }
    node.own += negate ? -posting.amount : posting.amount;
    node.ownEntries++;
  }

  /// A nameless node whose children are the root accounts.
  AccountNode build() => _root.build();
}

class _Draft {
  _Draft(this.account, this.name);

  final String account;
  final String name;
  final children = <String, _Draft>{};
  Money own = LedgerBook.zero;
  int ownEntries = 0;

  AccountNode build() {
    final built = [for (final child in children.values) child.build()]
      ..sort((a, b) => b.amount.compareTo(a.amount));
    return AccountNode(
      account: account,
      name: name,
      amount: built.fold(own, (total, child) => total + child.amount),
      ownAmount: own,
      ownEntryCount: ownEntries,
      children: built,
    );
  }
}
