import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/routing/routes.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/ui/rules/bloc/rules_cubit.dart';
import 'package:ledger_app/ui/rules/widgets/rule_list.dart';
import 'package:ledger_app/ui/settings/widgets/settings_tile.dart';

import '../widgets/setup_scaffold.dart';

const _formatExample = '''# ledger.rules
if %payee Sample Property
  account2 expenses:rent

if %payee BTS|MRT|Grab
  account2 expenses:transport

if %memo salary
  account2 income:salary''';

class SetupRulesView extends StatelessWidget {
  const SetupRulesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<RulesCubit>();
    final state = context.watch<RulesCubit>().state;
    final draft = state.draft;
    final busy =
        state.status == RulesStatus.picking ||
        state.status == RulesStatus.saving;
    final canImport = draft != null && draft.rules.isNotEmpty && !busy;
    return BlocListener<RulesCubit, RulesState>(
      listenWhen: (previous, current) =>
          (current.status == RulesStatus.done &&
              previous.status != RulesStatus.done) ||
          (current.error != null && previous.error != current.error),
      listener: (context, state) {
        if (state.status == RulesStatus.done) {
          context.push(Routes.setupPhotos);
          return;
        }
        final message = switch (state.error) {
          RulesError.fileFailed => l10n.rulesFileFailed,
          RulesError.noRules => l10n.rulesNoneFound,
          RulesError.saveFailed => l10n.rulesSaveFailed,
          RulesError.loadFailed || null => null,
        };
        if (message == null) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      },
      child: SetupScaffold(
        step: 3,
        footer: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: Dimens.gapXS,
          children: [
            if (canImport) ...[
              TuiButton.action(
                label: l10n.setupRulesSkip,
                onPressed: () => context.push(Routes.setupPhotos),
              ),
              TuiButton.primary(
                label: l10n.setupRulesImport(draft.rules.length),
                onPressed: cubit.commit,
              ),
            ] else
              TuiButton.primary(
                label: l10n.setupRulesSkip,
                onPressed: busy ? null : () => context.push(Routes.setupPhotos),
              ),
          ],
        ),
        children: [
          TuiPanel(
            title: l10n.setupRulesFileTitle,
            accent: true,
            trailing: l10n.setupRulesOptional,
            child: _FilePanel(fileName: draft?.fileName, busy: busy),
          ),
          const SizedBox(height: Dimens.panelGap),
          if (draft != null && draft.rules.isNotEmpty)
            TuiPanel(
              title: l10n.setupRulesFoundTitle,
              trailing: '✓ ${draft.rules.length}',
              trailingColor: Theme.of(context).colorScheme.tertiary,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.panelPadding,
                vertical: Dimens.gapXS,
              ),
              child: RuleList(rules: draft.rules, issues: draft.issues),
            )
          else
            const _FormatPanel(),
          const SizedBox(height: Dimens.gapM),
          SettingComment(l10n.setupRulesHintViewOnly, small: true),
          SettingComment(l10n.setupRulesHintEdit, small: true),
          SettingComment(l10n.setupRulesHintOrder, small: true),
        ],
      ),
    );
  }
}

class _FilePanel extends StatelessWidget {
  const _FilePanel({required this.fileName, required this.busy});

  final String? fileName;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final fileName = this.fileName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: Dimens.gapM,
          children: [
            Text(
              l10n.rulesFile.toLowerCase(),
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            Flexible(
              child: Text(
                fileName ?? l10n.rulesNone,
                overflow: TextOverflow.ellipsis,
                style: fileName == null
                    ? TextStyle(color: scheme.onSurfaceVariant)
                    : null,
              ),
            ),
          ],
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TuiButton.action(
            label: fileName == null
                ? l10n.rulesChooseAction
                : l10n.setupChooseAnother,
            padding: 0,
            onPressed: busy ? null : context.read<RulesCubit>().pickFile,
          ),
        ),
      ],
    );
  }
}

class _FormatPanel extends StatelessWidget {
  const _FormatPanel();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TuiPanel(
      title: context.l10n.setupRulesFormatTitle,
      background: scheme.surfaceContainerLow,
      child: Text(_formatExample, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
