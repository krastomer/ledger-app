import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/account_node.dart';
import 'package:ledger_app/domain/models/income_statement.dart';
import 'package:ledger_app/domain/models/ledger_book.dart';
import 'package:ledger_app/domain/models/posting.dart';
import 'package:ledger_app/utils/result.dart';
import 'package:money2/money2.dart';

class IncomeStatementUseCase {
  IncomeStatementUseCase({
    required this._ledgerRepository,
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final LedgerRepository _ledgerRepository;
  final DateTime Function() _now;

  Future<Result<IncomeStatement>> call({DateTime? month}) async {
    final accounts = await _ledgerRepository.getAccounts();
    final transactions = await _ledgerRepository.getTransactions();
    final now = _now();
    final latest = DateTime(now.year, now.month);
    final requested = month ?? latest;
    return switch ((accounts, transactions)) {
      (Ok(value: final accounts), Ok(value: final transactions)) => Result.ok(
        _statement(
          LedgerBook(accounts: accounts, transactions: transactions),
          DateTime(requested.year, requested.month),
          latest,
        ),
      ),
      (Error(:final error), _) ||
      (_, Error(:final error)) => Result.error(error),
    };
  }

  IncomeStatement _statement(LedgerBook book, DateTime month, DateTime latest) {
    final monthTransactions = book.inMonth(month);
    final incomeTree = _tree(
      book.postings(monthTransactions, AccountType.income),
      negate: true,
    );
    final expenseTree = _tree(
      book.postings(monthTransactions, AccountType.expense),
    );
    final income = incomeTree.amount;
    final expenses = expenseTree.amount;
    final net = income - expenses;
    return IncomeStatement(
      month: month,
      earliestMonth: book.earliestMonth ?? latest,
      latestMonth: latest,
      income: income,
      expenses: expenses,
      net: net,
      savingsPerMille: income.isPositive && net.isPositive
          ? LedgerBook.perMille(net, income)
          : null,
      expensesPerMille: income.isPositive
          ? LedgerBook.perMille(expenses, income)
          : null,
      expenseTree: expenseTree,
      incomeTree: incomeTree,
    );
  }

  AccountNode _tree(Iterable<Posting> postings, {bool negate = false}) {
    final root = _Draft('', '');
    for (final p in postings) {
      var node = root;
      for (final segment in p.account.split(accountSeparator)) {
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
      node.own += negate ? -p.amount : p.amount;
      node.ownEntries++;
    }
    final top = root.children.length == 1 && root.ownEntries == 0
        ? root.children.values.single
        : root;
    return top.build();
  }
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
