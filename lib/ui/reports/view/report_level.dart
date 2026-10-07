import 'dart:math' as math;

import 'package:ledger_app/domain/models/account_node.dart';
import 'package:ledger_app/domain/models/income_statement.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/utils/percent_format.dart';
import 'package:money2/money2.dart';

import '../bloc/reports_cubit.dart';

class ChartSlice {
  const ChartSlice({
    required this.label,
    required this.amount,
    required this.perMille,
    required this.subtitle,
    this.drillAccount,
    this.opensSide,
  });

  final String label;
  final Money amount;
  final int perMille;
  final String subtitle;
  final String? drillAccount;
  final ReportSide? opensSide;
}

class ParentRowData {
  const ParentRowData({
    required this.label,
    required this.subtitle,
    required this.perMille,
    required this.amount,
  });

  final String label;
  final String subtitle;
  final int? perMille;
  final Money amount;
}

class ReportLevel {
  const ReportLevel({
    required this.title,
    required this.slices,
    this.parent,
    this.incomeLink,
    this.caption,
  });

  final String title;
  final String? caption;
  final List<ChartSlice> slices;

  /// The row that goes back up a level; null at the net overview.
  final ParentRowData? parent;

  /// The overview's row that opens the income side.
  final ParentRowData? incomeLink;
}

ReportLevel buildReportLevel({
  required AppLocalizations l10n,
  required IncomeStatement statement,
  required ReportSide? side,
  required List<AccountNode> trail,
}) {
  if (side == null || trail.isEmpty) return _net(l10n, statement);
  return _node(l10n, statement, side, trail);
}

String _subtitle(AppLocalizations l10n, AccountNode node) => node.hasChildren
    ? l10n.subcategoriesCount(node.children.length)
    : l10n.entriesCount(node.entryCount);

ReportLevel _net(AppLocalizations l10n, IncomeStatement statement) {
  final saved = statement.savingsPerMille;
  return ReportLevel(
    title: l10n.netLabel,
    slices: [
      if (statement.expenses.isPositive)
        ChartSlice(
          label: l10n.expenses,
          amount: statement.expenses,
          perMille: math.min(statement.expensesPerMille ?? 1000, 1000),
          subtitle: _subtitle(l10n, statement.expenseTree),
          opensSide: ReportSide.expense,
        ),
      if (statement.net.isPositive)
        ChartSlice(
          label: l10n.leftOver,
          amount: statement.net,
          perMille: saved ?? 0,
          subtitle: '',
          opensSide: ReportSide.income,
        ),
    ],
    incomeLink: ParentRowData(
      label: l10n.income,
      subtitle: _subtitle(l10n, statement.incomeTree),
      perMille: statement.income.isPositive ? 1000 : null,
      amount: statement.income,
    ),
  );
}

ReportLevel _node(
  AppLocalizations l10n,
  IncomeStatement statement,
  ReportSide side,
  List<AccountNode> trail,
) {
  final node = trail.last;
  final depth = trail.length - 1;
  final isExpense = side == ReportSide.expense;
  final sideTitle = isExpense ? l10n.expenses : l10n.income;
  final name = depth == 0 ? sideTitle : node.name;
  final int? share;
  final String? parentName;
  if (depth == 0) {
    share = isExpense
        ? statement.expensesPerMille
        : (statement.income.isPositive ? 1000 : null);
    parentName = isExpense ? l10n.income : null;
  } else {
    final parent = trail[depth - 1];
    share = parent.allocations
        .where((a) => a.account == node.account)
        .firstOrNull
        ?.perMille;
    parentName = depth == 1 ? sideTitle : parent.name;
  }
  return ReportLevel(
    title: name,
    caption: share != null && parentName != null
        ? l10n.shareOfParent(formatPerMille(share), parentName)
        : null,
    slices: [
      for (final a in node.allocations)
        ChartSlice(
          label: a.account == null ? l10n.generalCategory : a.name,
          amount: a.amount,
          perMille: a.perMille,
          subtitle: a.childCount > 0
              ? l10n.subcategoriesCount(a.childCount)
              : l10n.entriesCount(a.entryCount),
          drillAccount: a.childCount > 0 ? a.account : null,
        ),
    ],
    parent: ParentRowData(
      label: name,
      subtitle: _subtitle(l10n, node),
      perMille: share,
      amount: node.amount,
    ),
  );
}
