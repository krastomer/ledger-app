import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/domain/models/account_node.dart';
import 'package:ledger_app/domain/models/account_type.dart';
import 'package:ledger_app/domain/models/accounts_summary.dart';
import 'package:ledger_app/domain/use_cases/accounts_summary_use_case.dart';
import 'package:ledger_app/utils/result.dart';

part 'accounts_cubit.freezed.dart';
part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  AccountsCubit({required this._accountsSummary})
    : super(const AccountsState());

  final AccountsSummaryUseCase _accountsSummary;

  Future<void> load() async {
    emit(state.copyWith(status: AccountsStatus.loading, error: null));
    final result = await _accountsSummary();
    if (isClosed) return;
    switch (result) {
      case Ok(:final value):
        emit(
          state.copyWith(
            status: AccountsStatus.success,
            summary: value,
            expanded: state.summary == null
                ? _defaultExpanded(value)
                : state.expanded,
          ),
        );
      case Error():
        emit(
          state.copyWith(
            status: AccountsStatus.failure,
            error: AccountsError.loadFailed,
          ),
        );
    }
  }

  void setMode(AccountsMode mode) => emit(state.copyWith(mode: mode));

  void toggle(String account) {
    final expanded = {...state.expanded};
    if (!expanded.remove(account)) expanded.add(account);
    emit(state.copyWith(expanded: expanded));
  }

  /// Assets and liabilities open two levels; income and expenses start
  /// collapsed.
  Set<String> _defaultExpanded(AccountsSummary summary) {
    final open = <String>{};
    void visit(AccountNode node, int depth) {
      if (depth < 2 && node.hasChildren) open.add(node.account);
      for (final child in node.children) {
        visit(child, depth + 1);
      }
    }

    for (final section in summary.sections) {
      if (section.type != AccountType.asset &&
          section.type != AccountType.liability) {
        continue;
      }
      for (final root in section.balance) {
        visit(root, 0);
      }
    }
    return open;
  }
}
