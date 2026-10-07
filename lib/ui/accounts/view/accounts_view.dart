import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/models/accounts_summary.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/utils/date_format.dart';
import 'package:money2/money2.dart';

import '../bloc/accounts_cubit.dart';
import '../widgets/account_row.dart';
import 'account_rows.dart';

class AccountsView extends StatelessWidget {
  const AccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    final summary = context.select(
      (AccountsCubit cubit) => cubit.state.summary,
    );
    final status = context.select((AccountsCubit cubit) => cubit.state.status);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _TopBar(),
            Expanded(
              child: summary != null
                  ? _AccountsContent(summary: summary)
                  : switch (status) {
                      AccountsStatus.initial ||
                      AccountsStatus.loading ||
                      AccountsStatus.success => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      AccountsStatus.failure => const _LoadFailure(),
                    },
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<AccountsCubit>();
    final mode = context.select((AccountsCubit cubit) => cubit.state.mode);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.pagePadding,
        Dimens.gapS,
        Dimens.pagePadding,
        0,
      ),
      child: Row(
        spacing: 6,
        children: [
          TuiButton(
            keyHint: 'q',
            label: l10n.back,
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            padding: 0,
            onPressed: () => Navigator.maybePop(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 6,
                children: [
                  TuiButton.chip(
                    label: l10n.balanceView,
                    selected: mode == AccountsMode.balance,
                    onPressed: () => cubit.setMode(AccountsMode.balance),
                  ),
                  TuiButton.chip(
                    label: l10n.monthChangeView,
                    selected: mode == AccountsMode.monthChange,
                    onPressed: () => cubit.setMode(AccountsMode.monthChange),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountsContent extends StatelessWidget {
  const _AccountsContent({required this.summary});

  final AccountsSummary summary;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountsCubit>();
    final mode = context.select((AccountsCubit cubit) => cubit.state.mode);
    final expanded = context.select(
      (AccountsCubit cubit) => cubit.state.expanded,
    );
    final l10n = context.l10n;
    final panels = visibleAccountRows(summary, mode, expanded);
    final month = formatMonthShortYear(
      summary.asOf,
      context.localeName,
      context.yearEra,
    );
    return RefreshIndicator(
      onRefresh: cubit.load,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          Dimens.pagePadding,
          Dimens.gapL,
          Dimens.pagePadding,
          Dimens.pagePadding,
        ),
        children: [
          if (summary.isEmpty) Text(l10n.noAccounts),
          if (panels.balanceSheet.isNotEmpty)
            TuiPanel(
              title: l10n.balanceSheetTitle,
              trailing: switch (mode) {
                AccountsMode.balance => l10n.accountsAsOf(
                  formatDate(summary.asOf, context.localeName, context.yearEra),
                ),
                AccountsMode.monthChange => month,
              },
              accent: true,
              padding: const EdgeInsets.fromLTRB(0, 10, 4, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ..._rows(panels.balanceSheet, expanded),
                  if (mode == AccountsMode.balance)
                    _NetWorthTotal(amount: summary.netWorth),
                ],
              ),
            ),
          if (panels.balanceSheet.isNotEmpty &&
              panels.incomeStatement.isNotEmpty)
            const SizedBox(height: Dimens.panelGap),
          if (panels.incomeStatement.isNotEmpty)
            TuiPanel(
              title: l10n.incomeStatementTitle,
              trailing: month,
              padding: const EdgeInsets.fromLTRB(0, 10, 4, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _rows(panels.incomeStatement, expanded),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _rows(List<AccountRowData> rows, Set<String> expanded) => [
    for (final (index, row) in rows.indexed) ...[
      if (row.isSectionStart && index > 0) const _SectionRule(),
      _Row(data: row, expanded: expanded.contains(row.node.account)),
    ],
  ];
}

class _Row extends StatelessWidget {
  const _Row({required this.data, required this.expanded});

  final AccountRowData data;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final node = data.node;
    return AccountRow(
      name: node.name,
      amount: node.amount,
      guides: data.guides,
      hasChildren: node.hasChildren,
      isExpanded: expanded,
      onToggle: () => context.read<AccountsCubit>().toggle(node.account),
    );
  }
}

class _SectionRule extends StatelessWidget {
  const _SectionRule();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.only(top: 2, bottom: Dimens.gapXS),
        child: SizedBox(width: Dimens.amountColumn, child: Divider()),
      ),
    );
  }
}

class _NetWorthTotal extends StatelessWidget {
  const _NetWorthTotal({required this.amount});

  final Money amount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rule = BorderSide(color: theme.colorScheme.onSurfaceVariant);
    const bold = TextStyle(fontWeight: FontWeight.w600);
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.gapXS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(border: Border(top: rule)),
          ),
          const SizedBox(height: 2),
          DecoratedBox(
            decoration: BoxDecoration(border: Border(top: rule)),
          ),
          SizedBox(
            height: 26,
            child: Row(
              spacing: 10,
              children: [
                SizedBox(
                  width: Dimens.amountColumn,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: AlignmentDirectional.centerEnd,
                    child: AmountText(
                      amount,
                      color: theme.colorScheme.primary,
                      style: bold,
                    ),
                  ),
                ),
                Text(context.l10n.netWorth.toLowerCase(), style: bold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadFailure extends StatelessWidget {
  const _LoadFailure();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Dimens.gapS,
        children: [
          Text(l10n.loadFailed),
          TuiButton.action(
            label: l10n.retry,
            onPressed: () => context.read<AccountsCubit>().load(),
          ),
        ],
      ),
    );
  }
}
