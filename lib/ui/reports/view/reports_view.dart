import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';

import '../bloc/reports_cubit.dart';
import '../widgets/allocation_rows.dart';
import '../widgets/daily_spend_panel.dart';
import '../widgets/income_statement_panel.dart';
import 'report_level.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final hasStatement = context.select(
      (ReportsCubit cubit) => cubit.state.statement != null,
    );
    final status = context.select((ReportsCubit cubit) => cubit.state.status);
    final isDrilled = context.select(
      (ReportsCubit cubit) => cubit.state.side != null,
    );
    return PopScope(
      canPop: !isDrilled,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.read<ReportsCubit>().back();
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _TopBar(),
              Expanded(
                child: hasStatement
                    ? const _ReportsContent()
                    : switch (status) {
                        ReportsStatus.initial ||
                        ReportsStatus.loading ||
                        ReportsStatus.success => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        ReportsStatus.failure => const _LoadFailure(),
                      },
              ),
            ],
          ),
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
    final cubit = context.read<ReportsCubit>();
    final statement = context.select(
      (ReportsCubit cubit) => cubit.state.statement,
    );
    final side = context.select((ReportsCubit cubit) => cubit.state.side);
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
                    label: l10n.netLabel,
                    selected: side == null,
                    onPressed: statement == null ? null : cubit.showOverview,
                  ),
                  TuiButton.chip(
                    label: l10n.expenses,
                    selected: side == ReportSide.expense,
                    onPressed: statement == null
                        ? null
                        : () => cubit.openSide(ReportSide.expense),
                  ),
                  TuiButton.chip(
                    label: l10n.income,
                    selected: side == ReportSide.income,
                    onPressed: statement == null
                        ? null
                        : () => cubit.openSide(ReportSide.income),
                  ),
                ],
              ),
            ),
          ),
          TuiButton(
            label: '<',
            tooltip: l10n.previousMonth,
            minWidth: 32,
            padding: 0,
            onPressed: statement == null || statement.isEarliestMonth
                ? null
                : cubit.previousMonth,
          ),
          TuiButton(
            label: '>',
            tooltip: l10n.nextMonth,
            minWidth: 32,
            padding: 0,
            onPressed: statement == null || statement.isLatestMonth
                ? null
                : cubit.nextMonth,
          ),
        ],
      ),
    );
  }
}

class _ReportsContent extends StatelessWidget {
  const _ReportsContent();

  @override
  Widget build(BuildContext context) {
    final state = context.select((ReportsCubit cubit) => cubit.state);
    final statement = state.statement;
    if (statement == null) return const SizedBox.shrink();
    final level = buildReportLevel(
      l10n: context.l10n,
      statement: statement,
      side: state.side,
      trail: state.trail,
    );
    return RefreshIndicator(
      onRefresh: context.read<ReportsCubit>().load,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          Dimens.pagePadding,
          Dimens.gapL,
          Dimens.pagePadding,
          Dimens.pagePadding,
        ),
        children: [
          IncomeStatementPanel(statement: statement),
          const SizedBox(height: Dimens.panelGap),
          if (statement.isEmpty)
            Text(
              context.l10n.noTransactionsThisMonth,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            )
          else ...[
            if (state.side != ReportSide.income) ...[
              DailySpendPanel(dailySpend: statement.dailySpend),
              const SizedBox(height: Dimens.panelGap),
            ],
            _LevelPanel(level: level),
          ],
        ],
      ),
    );
  }
}

class _LevelPanel extends StatelessWidget {
  const _LevelPanel({required this.level});

  final ReportLevel level;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReportsCubit>();
    final parent = level.parent;
    final incomeLink = level.incomeLink;
    return TuiPanel(
      title: level.title,
      trailing: level.caption,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AllocationHeader(),
          if (parent != null)
            ParentAllocationRow(
              label: parent.label,
              subtitle: parent.subtitle,
              perMille: parent.perMille,
              amount: parent.amount,
              onTap: cubit.back,
            ),
          for (final slice in level.slices)
            AllocationRow(
              label: slice.label,
              subtitle: slice.subtitle,
              perMille: slice.perMille,
              amount: slice.amount,
              onTap: switch ((slice.drillAccount, slice.opensSide)) {
                (final String account, _) => () => cubit.drillInto(account),
                (_, final ReportSide side) => () => cubit.openSide(side),
                _ => null,
              },
            ),
          if (incomeLink != null)
            AllocationRow(
              label: incomeLink.label,
              subtitle: incomeLink.subtitle,
              perMille: incomeLink.perMille,
              amount: incomeLink.amount,
              onTap: () => cubit.openSide(ReportSide.income),
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
            onPressed: () => context.read<ReportsCubit>().load(),
          ),
        ],
      ),
    );
  }
}
