import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/domain/models/review_item.dart';
import 'package:ledger_app/routing/routes.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/choice_page.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_dashed_line.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';

import '../bloc/inbox_cubit.dart';
import '../widgets/review_tile.dart';

/// The inbox tab. Its cubit lives above the tab bar, which shows the
/// open count.
class InboxView extends StatelessWidget {
  const InboxView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<InboxCubit, InboxState>(
          listenWhen: (previous, current) =>
              current.picked != null && previous.picked != current.picked,
          listener: (context, state) {
            final paths = state.picked;
            if (paths != null) context.push(Routes.slipReview, extra: paths);
          },
        ),
        BlocListener<InboxCubit, InboxState>(
          listenWhen: (previous, current) =>
              current.error != null && previous.error != current.error,
          listener: (context, state) {
            final message = switch (state.error) {
              InboxError.actionFailed => l10n.changeFailed,
              InboxError.pickFailed => l10n.photosFailed,
              InboxError.loadFailed || null => null,
            };
            if (message == null) return;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(message)));
          },
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: RefreshIndicator(
            onRefresh: context.read<InboxCubit>().load,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                Dimens.pagePadding,
                Dimens.gapL,
                Dimens.pagePadding,
                Dimens.pagePadding,
              ),
              children: [
                const _NewSlipsPanel(),
                const SizedBox(height: Dimens.panelGap),
                const _QueuePanel(),
                const SizedBox(height: Dimens.gapM),
                Text(
                  '# ${l10n.slipsReadOnDevice}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
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

class _NewSlipsPanel extends StatelessWidget {
  const _NewSlipsPanel();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TuiPanel(
      title: l10n.newSlipsTitle,
      accent: true,
      padding: const EdgeInsets.all(Dimens.panelPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: Dimens.gapM,
        children: [
          Text(l10n.newSlipsHint),
          TuiButton.primary(
            label: l10n.pickSlipsAction,
            onPressed: context.read<InboxCubit>().pickSlips,
          ),
        ],
      ),
    );
  }
}

class _QueuePanel extends StatelessWidget {
  const _QueuePanel();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final state = context.watch<InboxCubit>().state;
    final open = state.openItems;
    final resolved = [
      for (final item in state.resolved)
        if (!open.contains(item)) item,
    ];
    final tiles = [
      for (final item in open) _OpenTile(item: item),
      for (final item in resolved) ReviewTile(item: item, resolved: true),
    ];
    return TuiPanel(
      title: l10n.queueTitle,
      trailing: state.items == null ? null : l10n.openCount(open.length),
      padding: const EdgeInsets.fromLTRB(
        Dimens.panelPadding,
        Dimens.gapXS,
        Dimens.panelPadding,
        0,
      ),
      child: switch (state.status) {
        _ when tiles.isNotEmpty => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final (index, tile) in tiles.indexed) ...[
              if (index > 0) const TuiDashedLine(),
              tile,
            ],
          ],
        ),
        InboxStatus.initial || InboxStatus.loading => const Padding(
          padding: EdgeInsets.all(Dimens.gapL),
          child: Center(child: CircularProgressIndicator()),
        ),
        InboxStatus.failure => Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.gapS),
          child: Row(
            children: [
              Expanded(child: Text(l10n.loadFailed)),
              TuiButton.action(
                label: l10n.retry,
                onPressed: context.read<InboxCubit>().load,
              ),
            ],
          ),
        ),
        InboxStatus.success => Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.gapM),
          child: Text(
            l10n.nothingToReview,
            style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
      },
    );
  }
}

class _OpenTile extends StatelessWidget {
  const _OpenTile({required this.item});

  final ReviewItem item;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<InboxCubit>();
    return ReviewTile(
      item: item,
      onOpen: () => context.push(Routes.transactionPath(item.transaction.id)),
      onConfirm: () => cubit.confirm(item),
      onKeep: () => cubit.keep(item),
      onDrop: () => cubit.dropDuplicate(item),
      onCategorize: () => _categorize(context, cubit),
    );
  }

  Future<void> _categorize(BuildContext context, InboxCubit cubit) async {
    final current = item.uncategorizedAccount;
    if (current == null) return;
    final picked = await pickChoice<String>(
      context,
      title: context.l10n.categoryTitle,
      selected: current,
      searchable: true,
      options: [for (final account in item.categoryChoices) (account, account)],
    );
    if (picked != null) await cubit.categorize(item, picked);
  }
}
