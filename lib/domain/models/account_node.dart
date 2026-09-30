import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

import 'allocation.dart';
import 'ledger_book.dart';

part 'account_node.freezed.dart';

@freezed
abstract class AccountNode with _$AccountNode {
  const factory AccountNode({
    required String account,
    required String name,

    /// Own postings plus everything below.
    required Money amount,
    required Money ownAmount,
    required int ownEntryCount,
    required List<AccountNode> children,
  }) = _AccountNode;

  const AccountNode._();

  bool get hasChildren => children.isNotEmpty;

  int get entryCount =>
      children.fold(ownEntryCount, (count, child) => count + child.entryCount);

  /// Positive children largest first, then the postings made directly on
  /// this account.
  List<Allocation> get allocations {
    final parts = [
      for (final child in children)
        if (child.amount.isPositive)
          (
            account: child.account as String?,
            name: child.name,
            amount: child.amount,
            entries: child.entryCount,
            childCount: child.children.length,
          ),
      if (hasChildren && ownAmount.isPositive)
        (
          account: null,
          name: '',
          amount: ownAmount,
          entries: ownEntryCount,
          childCount: 0,
        ),
    ];
    final whole = parts.fold(LedgerBook.zero, (sum, p) => sum + p.amount);
    return [
      for (final p in parts)
        Allocation(
          account: p.account,
          name: p.name,
          amount: p.amount,
          perMille: LedgerBook.perMille(p.amount, whole),
          entryCount: p.entries,
          childCount: p.childCount,
        ),
    ];
  }
}
