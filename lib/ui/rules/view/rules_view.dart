import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/models/rule_set.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/ui/settings/widgets/settings_tile.dart';
import 'package:ledger_app/utils/date_format.dart';

import '../bloc/rules_cubit.dart';
import '../widgets/rule_list.dart';

class RulesView extends StatelessWidget {
  const RulesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return BlocListener<RulesCubit, RulesState>(
      listenWhen: (previous, current) =>
          current.error != null && previous.error != current.error,
      listener: (context, state) {
        final message = switch (state.error) {
          RulesError.loadFailed => l10n.rulesLoadFailed,
          RulesError.fileFailed => l10n.rulesFileFailed,
          RulesError.noRules => l10n.rulesNoneFound,
          RulesError.saveFailed => l10n.rulesSaveFailed,
          null => null,
        };
        if (message == null) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Dimens.pagePadding,
                  Dimens.gapS,
                  Dimens.pagePadding,
                  0,
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TuiButton(
                    keyHint: 'q',
                    label: l10n.back,
                    tooltip: MaterialLocalizations.of(context)
                        .backButtonTooltip,
                    padding: 0,
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
              ),
              const Expanded(child: _Content()),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainer,
                  border: Border(top: BorderSide(color: scheme.outlineVariant)),
                ),
                child: const SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimens.pagePadding,
                      vertical: Dimens.gapS,
                    ),
                    child: _Footer(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    final (status, saved) = context.select(
      (RulesCubit cubit) => (cubit.state.status, cubit.state.saved),
    );
    if (saved == null) {
      return switch (status) {
        RulesStatus.initial ||
        RulesStatus.loading => const Center(child: CircularProgressIndicator()),
        _ => const _NoFile(),
      };
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.pagePadding,
        Dimens.gapL,
        Dimens.pagePadding,
        Dimens.pagePadding,
      ),
      children: [
        TuiPanel(
          title: context.l10n.rulesSourceTitle,
          accent: true,
          child: _SourceLines(rules: saved),
        ),
        const SizedBox(height: Dimens.panelGap),
        TuiPanel(
          title: context.l10n.rulesTitle,
          trailing: context.l10n.rulesCount(saved.rules.length),
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.panelPadding,
            vertical: Dimens.gapXS,
          ),
          child: RuleList(rules: saved.rules, issues: const []),
        ),
        const SizedBox(height: Dimens.gapM),
        SettingComment(context.l10n.rulesViewOnly, small: true),
        SettingComment(context.l10n.rulesReplaceNote, small: true),
        SettingComment(context.l10n.rulesFirstMatch, small: true),
      ],
    );
  }
}

class _SourceLines extends StatelessWidget {
  const _SourceLines({required this.rules});

  final RuleSet rules;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final loaded = rules.loadedAt;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Line(label: l10n.rulesFile, value: rules.fileName),
        _Line(
          label: l10n.rulesLoaded,
          value:
              '${formatIsoDate(loaded)} '
              '${formatTime(Duration(hours: loaded.hour, minutes: loaded.minute))}',
        ),
        if (rules.issues.isNotEmpty)
          _Line(
            label: l10n.rulesSkipped,
            value: '! ${rules.issues.length}',
            color: scheme.error,
          ),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value, this.color});

  final String label;
  final String value;
  final Color? color;

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
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: color),
          ),
        ),
      ],
    );
  }
}

class _NoFile extends StatelessWidget {
  const _NoFile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(Dimens.pagePadding),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: SettingComment(l10n.rulesNoFile),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final (busy, hasFile) = context.select(
      (RulesCubit cubit) => (
        cubit.state.status == RulesStatus.picking ||
            cubit.state.status == RulesStatus.saving,
        cubit.state.saved != null,
      ),
    );
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TuiButton.primary(
        label: hasFile ? l10n.rulesReplaceAction : l10n.rulesChooseAction,
        onPressed: busy ? null : context.read<RulesCubit>().replace,
      ),
    );
  }
}
