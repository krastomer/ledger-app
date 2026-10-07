import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/utils/date_format.dart';

import '../bloc/transactions_cubit.dart';
import '../widgets/filter_bar.dart';
import '../widgets/month_totals_card.dart';
import '../widgets/search_field.dart';
import '../widgets/transaction_day_section.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(),
            _Totals(),
            Expanded(child: _Register()),
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
    final l10n = context.l10n;
    final data = context.select((TransactionsCubit cubit) => cubit.state.data);
    final cubit = context.read<TransactionsCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.pagePadding,
        Dimens.gapS,
        Dimens.pagePadding,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 6,
        children: [
          Row(
            children: [
              TuiButton(
                label: '<',
                tooltip: l10n.previousMonth,
                minWidth: 36,
                padding: 0,
                onPressed: data == null || data.isEarliestMonth
                    ? null
                    : cubit.previousMonth,
              ),
              if (data != null)
                Text(
                  formatMonthShortYear(
                    data.month,
                    context.localeName,
                    context.yearEra,
                  ),
                ),
              TuiButton(
                label: '>',
                tooltip: l10n.nextMonth,
                minWidth: 36,
                padding: 0,
                onPressed: data == null || data.isLatestMonth
                    ? null
                    : cubit.nextMonth,
              ),
              const SizedBox(width: Dimens.gapXS),
              const Expanded(child: SearchField()),
            ],
          ),
          const FilterBar(),
        ],
      ),
    );
  }
}

class _Totals extends StatelessWidget {
  const _Totals();

  @override
  Widget build(BuildContext context) {
    final data = context.select((TransactionsCubit cubit) => cubit.state.data);
    if (data == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.pagePadding,
        Dimens.gapS,
        Dimens.pagePadding,
        0,
      ),
      child: MonthTotalsCard(
        income: data.income,
        expenses: data.expenses,
        net: data.net,
      ),
    );
  }
}

class _Register extends StatelessWidget {
  const _Register();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final count = context.select(
      (TransactionsCubit cubit) => cubit.state.data?.transactionCount,
    );
    final status = context.select(
      (TransactionsCubit cubit) => cubit.state.status,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.pagePadding,
        Dimens.panelGap,
        Dimens.pagePadding,
        0,
      ),
      child: TuiPanel(
        title: l10n.registerTitle,
        trailing: count == null ? null : l10n.shownCount(count),
        accent: true,
        openBottom: true,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: count != null
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
        padding: const EdgeInsets.only(bottom: Dimens.pagePadding),
        itemCount: data.isEmpty ? 1 : data.days.length,
        itemBuilder: (context, index) => data.isEmpty
            ? _EmptyMessage(isFiltered: isFiltered)
            : TransactionDaySection(day: data.days[index]),
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
      padding: const EdgeInsets.symmetric(vertical: Dimens.gapXL),
      child: Text(
        isFiltered ? l10n.noMatchingTransactions : l10n.noTransactionsThisMonth,
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
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
            onPressed: () => context.read<TransactionsCubit>().load(),
          ),
        ],
      ),
    );
  }
}
