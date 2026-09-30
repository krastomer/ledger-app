import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/themes/money_colors.dart';
import 'package:ledger_app/utils/percent_format.dart';

import '../bloc/reports_cubit.dart';
import '../widgets/allocation_rows.dart';
import '../widgets/donut_chart.dart';
import '../widgets/month_switcher.dart';
import '../widgets/report_total.dart';
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
        appBar: AppBar(
          leading: isDrilled
              ? BackButton(onPressed: () => context.read<ReportsCubit>().back())
              : null,
          title: Text(context.l10n.reportsTitle),
        ),
        body: SafeArea(
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
    final cubit = context.read<ReportsCubit>();
    final level = buildReportLevel(
      l10n: context.l10n,
      colors: Theme.of(context).moneyColors,
      statement: statement,
      side: state.side,
      trail: state.trail,
    );
    return Column(
      children: [
        MonthSwitcher(
          month: statement.month,
          canGoPrevious: !statement.isEarliestMonth,
          canGoNext: !statement.isLatestMonth,
          onPrevious: cubit.previousMonth,
          onNext: cubit.nextMonth,
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: cubit.load,
            child: statement.isEmpty
                ? const _EmptyMonth()
                : _Level(level: level),
          ),
        ),
      ],
    );
  }
}

class _EmptyMonth extends StatelessWidget {
  const _EmptyMonth();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(Dimens.gapXL),
      children: [Center(child: Text(context.l10n.noTransactionsThisMonth))],
    );
  }
}

class _Level extends StatelessWidget {
  const _Level({required this.level});

  final ReportLevel level;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReportsCubit>();
    final slices = level.slices;
    final parent = level.parent;
    final incomeLink = level.incomeLink;
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.pagePadding),
          sliver: SliverList.list(
            children: [
              ReportTotal(
                title: level.title,
                total: level.total,
                showPlus: level.showPlus,
                caption: level.caption,
              ),
              const SizedBox(height: Dimens.gapS),
              DonutChart(
                slices: [
                  for (final slice in slices)
                    DonutSlice(
                      weight: slice.amount.minorUnits.toDouble(),
                      color: slice.color,
                      textColor: _textOn(slice.color, Theme.of(context)),
                      name: slice.label,
                      value: formatPerMille(slice.perMille),
                    ),
                ],
                center: _Center(level: level),
                onCenterTap: level.parent != null ? cubit.back : null,
                onSliceTap: (index) {
                  final slice = slices[index];
                  final account = slice.drillAccount;
                  final side = slice.opensSide;
                  if (account != null) {
                    cubit.drillInto(account);
                  } else if (side != null) {
                    cubit.openSide(side);
                  }
                },
              ),
              const SizedBox(height: Dimens.gapM),
              const AllocationHeader(),
              if (parent != null)
                ParentAllocationRow(
                  label: parent.label,
                  subtitle: parent.subtitle,
                  perMille: parent.perMille,
                  amount: parent.amount,
                  onTap: cubit.back,
                ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.pagePadding,
            0,
            Dimens.pagePadding,
            Dimens.pagePadding,
          ),
          sliver: SliverList.separated(
            itemCount: slices.length + (incomeLink == null ? 0 : 1),
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, index) {
              if (index == slices.length && incomeLink != null) {
                return AllocationRow(
                  color: Theme.of(context).moneyColors.income,
                  label: incomeLink.label,
                  subtitle: incomeLink.subtitle,
                  perMille: incomeLink.perMille,
                  amount: incomeLink.amount,
                  onTap: () => cubit.openSide(ReportSide.income),
                );
              }
              final slice = slices[index];
              return AllocationRow(
                color: slice.color,
                label: slice.label,
                subtitle: slice.subtitle,
                perMille: slice.perMille,
                amount: slice.amount,
              );
            },
          ),
        ),
      ],
    );
  }

  Color _textOn(Color fill, ThemeData theme) {
    final light = theme.colorScheme.surface;
    final dark = theme.colorScheme.onSurface;
    final fillLuminance = fill.computeLuminance();
    return (light.computeLuminance() - fillLuminance).abs() >
            (dark.computeLuminance() - fillLuminance).abs()
        ? light
        : dark;
  }
}

class _Center extends StatelessWidget {
  const _Center({required this.level});

  final ReportLevel level;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final value = level.centerValue;
    switch (level.center) {
      case CenterKind.hint:
        return Text(
          context.l10n.tapSliceToDrill,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        );
      case CenterKind.saved:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              level.centerLabel ?? '',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (value != null)
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: level.centerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        );
      case CenterKind.badge:
        final onColor =
            ThemeData.estimateBrightnessForColor(level.centerColor) ==
                Brightness.dark
            ? theme.colorScheme.surface
            : theme.colorScheme.onSurface;
        return DecoratedBox(
          decoration: BoxDecoration(
            color: level.centerColor,
            shape: BoxShape.circle,
          ),
          child: FractionallySizedBox(
            widthFactor: 0.8,
            heightFactor: 0.8,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.gapXS),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      level.centerLabel ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: onColor,
                      ),
                    ),
                    if (value != null)
                      Text(
                        value,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: onColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
    }
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
        spacing: Dimens.gapM,
        children: [
          Text(l10n.loadFailed),
          FilledButton.tonal(
            onPressed: () => context.read<ReportsCubit>().load(),
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }
}
