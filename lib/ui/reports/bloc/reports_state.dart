part of 'reports_cubit.dart';

enum ReportsStatus { initial, loading, success, failure }

enum ReportsError { loadFailed }

enum ReportSide { expense, income }

@freezed
abstract class ReportsState with _$ReportsState {
  const factory ReportsState({
    @Default(ReportsStatus.initial) ReportsStatus status,
    IncomeStatement? statement,
    ReportSide? side,
    @Default([]) List<String> drill,
    ReportsError? error,
  }) = _ReportsState;

  const ReportsState._();

  /// The tree nodes from the side's top account down to the current level;
  /// empty at the net overview.
  List<AccountNode> get trail {
    final current = statement;
    final side = this.side;
    if (current == null || side == null) return const [];
    final top = switch (side) {
      ReportSide.expense => current.expenseTree,
      ReportSide.income => current.incomeTree,
    };
    final nodes = [top];
    for (final account in drill) {
      final next = nodes.last.children
          .where((child) => child.account == account)
          .firstOrNull;
      if (next == null) return const [];
      nodes.add(next);
    }
    return nodes;
  }
}
