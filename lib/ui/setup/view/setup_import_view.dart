import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/models/ledger_import_draft.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/utils/date_format.dart';
import 'package:ledger_app/utils/file_size_format.dart';

import '../bloc/setup_cubit.dart';
import '../widgets/setup_listener.dart';
import '../widgets/setup_scaffold.dart';

class SetupImportView extends StatelessWidget {
  const SetupImportView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<SetupCubit>().state;
    final cubit = context.read<SetupCubit>();
    final draft = state.draft;
    final busy =
        state.status == SetupStatus.picking ||
        state.status == SetupStatus.saving;
    return SetupListener(
      child: SetupScaffold(
        footer: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TuiButton.primary(
            label: l10n.setupImportAction(draft?.transactionCount ?? 0),
            onPressed: draft == null || busy ? null : cubit.importDraft,
          ),
        ),
        children: [
          TuiPanel(
            title: l10n.setupSourceTitle,
            accent: true,
            child: _SourcePanel(state: state, busy: busy),
          ),
          if (draft != null) ...[
            const SizedBox(height: Dimens.panelGap),
            TuiPanel(
              title: l10n.setupFoundTitle,
              child: _FoundPanel(draft: draft),
            ),
          ],
        ],
      ),
    );
  }
}

class _SourcePanel extends StatelessWidget {
  const _SourcePanel({required this.state, required this.busy});

  final SetupState state;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final draft = state.draft;
    final error = switch (state.error) {
      SetupError.unreadableFile => l10n.setupUnreadable(state.unreadableCount),
      SetupError.fileFailed => l10n.setupFileFailed,
      SetupError.saveFailed || null => null,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (draft == null)
          Text(
            '# ${l10n.setupPickHint}',
            style: theme.textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
              color: scheme.onSurfaceVariant,
            ),
          )
        else ...[
          _Line(label: l10n.setupFile, value: draft.fileName),
          _Line(label: l10n.setupSize, value: formatFileSize(draft.sizeBytes)),
        ],
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(top: Dimens.gapXS),
            child: Text(
              '! $error',
              style: theme.textTheme.bodySmall?.copyWith(color: scheme.error),
            ),
          ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TuiButton.action(
            label: draft == null
                ? l10n.setupChooseFile
                : l10n.setupChooseAnother,
            padding: 0,
            onPressed: busy ? null : context.read<SetupCubit>().pickFile,
          ),
        ),
      ],
    );
  }
}

class _FoundPanel extends StatelessWidget {
  const _FoundPanel({required this.draft});

  final LedgerImportDraft draft;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final first = draft.firstDate;
    final last = draft.lastDate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Line(
          label: l10n.setupTransactions,
          value: '${draft.transactionCount}',
        ),
        _Line(label: l10n.accountsTitle, value: '${draft.accountCount}'),
        if (first != null && last != null)
          _Line(
            label: l10n.setupRange,
            value: '${formatIsoDate(first)} → ${formatIsoDate(last)}',
          ),
        const SizedBox(height: Dimens.gapXS),
        if (draft.unbalancedCount == 0)
          Text(
            '✓ ${l10n.setupAllBalanced.toLowerCase()}',
            style: TextStyle(color: scheme.tertiary),
          )
        else
          Text(
            '! ${l10n.setupUnbalanced(draft.unbalancedCount)}',
            style: TextStyle(color: scheme.error),
          ),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: Dimens.gapM,
      children: [
        Text(
          label.toLowerCase(),
          style: TextStyle(color: scheme.onSurfaceVariant),
        ),
        Flexible(child: Text(value, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
