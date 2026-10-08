import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/models/found_slip.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_dashed_line.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/ui/settings/widgets/settings_tile.dart';
import 'package:ledger_app/utils/date_format.dart';

import '../bloc/setup_scan_cubit.dart';
import '../widgets/setup_scaffold.dart';

class SetupFoundView extends StatelessWidget {
  const SetupFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<SetupScanCubit>().state;
    final cubit = context.read<SetupScanCubit>();
    final selected = state.selected.length;
    final importable = state.found.where((slip) => slip.importable).length;
    final saving = state.phase != SetupScanPhase.review;
    return SetupScaffold(
      step: 4,
      footer: Row(
        spacing: Dimens.gapS,
        children: [
          Expanded(
            child: SettingComment(l10n.setupFoundInboxHint, small: true),
          ),
          TuiButton.primary(
            label: selected == 0
                ? l10n.setupFoundSkip
                : l10n.setupFoundImport(selected),
            onPressed: saving
                ? null
                : selected == 0
                ? cubit.skip
                : cubit.importSelected,
          ),
        ],
      ),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.setupFoundSelected(selected, state.found.length),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            TuiButton.action(
              label: selected == importable
                  ? l10n.setupSelectNone
                  : l10n.setupSelectAll,
              onPressed: saving
                  ? null
                  : () => cubit.selectAll(selected != importable),
            ),
          ],
        ),
        const SizedBox(height: Dimens.gapM),
        for (final group in FoundSlipGroup.values)
          _Group(group: group, slips: state.found, state: state),
      ],
    );
  }
}

class _Group extends StatelessWidget {
  const _Group({required this.group, required this.slips, required this.state});

  final FoundSlipGroup group;
  final List<FoundSlip> slips;
  final SetupScanState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final rows = [
      for (final slip in slips)
        if (slip.group == group) slip,
    ];
    if (rows.isEmpty) return const SizedBox.shrink();
    final picked = rows.where((s) => state.selected.contains(s.id)).length;
    final unsure = group == FoundSlipGroup.unsure;
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.panelGap),
      child: TuiPanel(
        title: switch (group) {
          FoundSlipGroup.transfer => l10n.setupFoundTransfers,
          FoundSlipGroup.payment => l10n.setupFoundPayments,
          FoundSlipGroup.order => l10n.setupFoundOrders,
          FoundSlipGroup.unsure => l10n.setupFoundUnsure,
        },
        accent: !unsure,
        borderColor: unsure ? scheme.error : null,
        trailing: '$picked/${rows.length}',
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.panelPadding,
          vertical: Dimens.gapXS,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < rows.length; i++) ...[
              if (i > 0) TuiDashedLine(color: scheme.surfaceContainerHigh),
              _Row(
                slip: rows[i],
                selected: state.selected.contains(rows[i].id),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.slip, required this.selected});

  final FoundSlip slip;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final transaction = slip.transaction;
    final amount = slip.amount;
    final color = selected ? scheme.onSurface : scheme.onSurfaceVariant;
    return Semantics(
      checked: selected,
      enabled: slip.importable,
      child: InkWell(
        onTap: slip.importable
            ? () => context.read<SetupScanCubit>().toggle(slip.id)
            : null,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Row(
            spacing: Dimens.gapS,
            children: [
              ExcludeSemantics(
                child: Text(
                  slip.importable ? (selected ? '[x]' : '[ ]') : '[-]',
                  style: TextStyle(color: scheme.primary),
                ),
              ),
              Text(
                transaction == null ? '--' : formatMonthDay(transaction.date),
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
              Expanded(
                child: Text(
                  transaction?.description ?? l10n.setupFoundNoAmount,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: color),
                ),
              ),
              if (amount != null)
                AmountText(amount, color: color)
              else
                Text('—', style: TextStyle(color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
