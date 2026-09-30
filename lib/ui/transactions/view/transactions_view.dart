import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/utils/date_format.dart';

import '../bloc/transactions_cubit.dart';
import '../widgets/filter_bar.dart';
import '../widgets/month_totals_card.dart';
import '../widgets/transaction_day_section.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final hasData = context.select(
      (TransactionsCubit cubit) => cubit.state.data != null,
    );
    final status = context.select(
      (TransactionsCubit cubit) => cubit.state.status,
    );
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _Header(),
            const FilterBar(),
            Expanded(
              child: hasData
                  ? const _Content()
                  : switch (status) {
                      TransactionsStatus.initial ||
                      TransactionsStatus.loading ||
                      TransactionsStatus.success => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      TransactionsStatus.failure => const _LoadFailure(),
                    },
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final data = context.select((TransactionsCubit cubit) => cubit.state.data);
    final cubit = context.read<TransactionsCubit>();
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        Dimens.gapXL,
        Dimens.gapS,
        Dimens.gapS,
        Dimens.gapS,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data != null)
                  Text(
                    formatMonthYear(
                      data.month,
                      context.localeName,
                      context.yearEra,
                    ),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                Text(
                  l10n.navTransactions,
                  style: theme.textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: l10n.previousMonth,
            onPressed: data == null || data.isEarliestMonth
                ? null
                : cubit.previousMonth,
            icon: const Icon(Icons.chevron_left),
          ),
          IconButton(
            tooltip: l10n.nextMonth,
            onPressed: data == null || data.isLatestMonth
                ? null
                : cubit.nextMonth,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final data = context.select((TransactionsCubit cubit) => cubit.state.data);
    final isFiltered = context.select(
      (TransactionsCubit cubit) => cubit.state.filter.isActive,
    );
    if (data == null) return const SizedBox.shrink();
    return RefreshIndicator(
      onRefresh: () => context.read<TransactionsCubit>().load(),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          Dimens.pagePadding,
          Dimens.gapS,
          Dimens.pagePadding,
          Dimens.pagePadding,
        ),
        itemCount: data.isEmpty ? 2 : data.days.length + 1,
        itemBuilder: (context, index) => switch (index) {
          0 => MonthTotalsCard(
            income: data.income,
            expenses: data.expenses,
            net: data.net,
          ),
          _ when data.isEmpty => _EmptyMessage(isFiltered: isFiltered),
          _ => TransactionDaySection(day: data.days[index - 1]),
        },
      ),
    );
  }
}

class _EmptyMessage extends StatelessWidget {
  const _EmptyMessage({required this.isFiltered});

  final bool isFiltered;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(Dimens.gapXL),
      child: Center(
        child: Text(
          isFiltered
              ? l10n.noMatchingTransactions
              : l10n.noTransactionsThisMonth,
        ),
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
        spacing: Dimens.gapM,
        children: [
          Text(l10n.loadFailed),
          FilledButton.tonal(
            onPressed: () => context.read<TransactionsCubit>().load(),
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }
}
