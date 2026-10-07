import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/domain/models/account_node.dart';
import 'package:ledger_app/domain/models/account_tree_builder.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/accounts_summary.dart';
import 'package:ledger_app/domain/models/ledger_book.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/utils/result.dart';

class AccountsSummaryUseCase {
  AccountsSummaryUseCase({
    required this._ledgerRepository,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final LedgerRepository _ledgerRepository;
  final DateTime Function() _now;

  Future<Result<AccountsSummary>> call() async {
    final accounts = await _ledgerRepository.getAccounts();
    final transactions = await _ledgerRepository.getTransactions();
    return switch ((accounts, transactions)) {
      (Ok(value: final accounts), Ok(value: final transactions)) => Result.ok(
        _summary(
          LedgerBook(accounts: accounts, transactions: transactions),
          _now(),
        ),
      ),
      (Error(:final error), _) ||
      (_, Error(:final error)) => Result.error(error),
    };
  }

  AccountsSummary _summary(LedgerBook book, DateTime now) {
    final all = book.transactions;
    final month = book.inMonth(now);
    final assets = book.sum(all, AccountType.asset);
    final liabilities = -book.sum(all, AccountType.liability);

    AccountSection section(
      AccountType type, {
      bool negate = false,
      bool monthly = false,
    }) {
      final change = _roots(book, month, type, negate);
      return AccountSection(
        type: type,
        balance: monthly ? change : _roots(book, all, type, negate),
        monthChange: change,
      );
    }

    return AccountsSummary(
      asOf: now,
      netWorth: assets - liabilities,
      assets: assets,
      liabilities: liabilities,
      sections: [
        section(AccountType.asset),
        section(AccountType.liability, negate: true),
        section(AccountType.income, negate: true, monthly: true),
        section(AccountType.expense, monthly: true),
      ],
    );
  }

  List<AccountNode> _roots(
    LedgerBook book,
    List<LedgerTransaction> from,
    AccountType type,
    bool negate,
  ) {
    final builder = AccountTreeBuilder();
    for (final p in book.postings(from, type)) {
      builder.add(p, negate: negate);
    }
    return builder.build().children;
  }
}
