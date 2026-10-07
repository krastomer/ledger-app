import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/routing/routes.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';

import '../bloc/home_cubit.dart';
import '../widgets/month_summary_card.dart';
import '../widgets/net_worth_card.dart';
import '../widgets/recent_transactions.dart';
import '../widgets/review_banner.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final hasSummary = context.select(
      (HomeCubit cubit) => cubit.state.summary != null,
    );
    final status = context.select((HomeCubit cubit) => cubit.state.status);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: hasSummary
            ? const _HomeContent()
            : switch (status) {
                HomeStatus.initial ||
                HomeStatus.loading ||
                HomeStatus.success => const Center(
                  child: CircularProgressIndicator(),
                ),
                HomeStatus.failure => const _LoadFailure(),
              },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final summary = context.select((HomeCubit cubit) => cubit.state.summary);
    final hidden = context.select(
      (HomeCubit cubit) => cubit.state.amountsHidden,
    );
    if (summary == null) return const SizedBox.shrink();
    final cubit = context.read<HomeCubit>();
    return RefreshIndicator(
      onRefresh: cubit.load,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          Dimens.pagePadding,
          Dimens.gapL,
          Dimens.pagePadding,
          Dimens.pagePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: Dimens.panelGap,
          children: [
            NetWorthCard(
              netWorth: summary.netWorth,
              assets: summary.assets,
              liabilities: summary.liabilities,
              amountsHidden: hidden,
              onTap: () => context.go(Routes.accounts),
            ),
            if (summary.reviewCount > 0)
              ReviewBanner(
                count: summary.reviewCount,
                onTap: () => context.go(Routes.inbox),
              ),
            MonthSummaryCard(
              month: summary.asOf,
              income: summary.monthIncome,
              expenses: summary.monthExpenses,
              net: summary.monthNet,
              topSpending: summary.topSpending,
              amountsHidden: hidden,
              onSeeReports: () => context.go(Routes.reports),
            ),
            RecentTransactions(
              transactions: summary.recent,
              amountsHidden: hidden,
              onSeeAll: () => context.go(Routes.transactions),
            ),
          ],
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
        spacing: Dimens.gapS,
        children: [
          Text(l10n.loadFailed),
          TuiButton.action(
            label: l10n.retry,
            onPressed: () => context.read<HomeCubit>().load(),
          ),
        ],
      ),
    );
  }
}
