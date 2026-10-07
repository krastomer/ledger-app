import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/models/slip_draft.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/choice_dialog.dart';
import 'package:ledger_app/ui/core/widgets/text_input_dialog.dart';
import 'package:ledger_app/ui/core/widgets/tui_bar.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';

import '../bloc/slip_review_bloc.dart';
import '../widgets/slip_panels.dart';

class SlipReviewView extends StatelessWidget {
  const SlipReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<SlipReviewBloc, SlipReviewState>(
      listenWhen: (previous, current) =>
          previous.status != current.status || previous.error != current.error,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);
        if (state.status == SlipReviewStatus.finished) {
          if (state.savedCount > 0) {
            messenger.showSnackBar(
              SnackBar(content: Text(l10n.slipsSaved(state.savedCount))),
            );
          }
          Navigator.of(context).maybePop();
        } else if (state.error == SlipReviewError.saveFailed) {
          messenger
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.changeFailed)));
        }
      },
      child: const Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopBar(),
              Expanded(child: _Body()),
              _ActionBar(),
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
    final scheme = Theme.of(context).colorScheme;
    final (index, count) = context.select(
      (SlipReviewBloc bloc) => (bloc.state.index, bloc.state.imagePaths.length),
    );
    final shown = index < count ? index + 1 : count;
    final muted = TextStyle(color: scheme.onSurfaceVariant);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.pagePadding,
        Dimens.gapS,
        Dimens.pagePadding,
        0,
      ),
      child: Row(
        spacing: Dimens.gapS,
        children: [
          TuiButton(
            keyHint: 'q',
            label: l10n.closeAction,
            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
            padding: 0,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          Expanded(
            child: Semantics(
              label: l10n.slipProgress(shown, count),
              child: ExcludeSemantics(
                child: Row(
                  spacing: Dimens.gapXS,
                  children: [
                    Text('[', style: muted),
                    Expanded(
                      child: TuiBar(
                        fraction: count == 0 ? 0 : index / count,
                        color: scheme.primary,
                      ),
                    ),
                    Text(']', style: muted),
                    Text('$shown/$count'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<SlipReviewBloc>().state;
    final draft = state.draft;
    final children = switch ((state.status, draft)) {
      (_, final SlipDraft draft) => [
        SlipSummaryPanel(draft: draft),
        const SizedBox(height: Dimens.panelGap),
        SlipFieldsPanel(
          draft: draft,
          onEditPayee: () => _editDescription(context, draft),
        ),
        const SizedBox(height: Dimens.panelGap),
        WillWritePanel(
          draft: draft,
          onEditDescription: () => _editDescription(context, draft),
          onPickAccount: (index) => _pickAccount(context, draft, index),
        ),
      ],
      (SlipReviewStatus.unreadable, _) => [
        _Message(text: l10n.slipUnreadable, isError: true),
      ],
      (SlipReviewStatus.finished, _) => const <Widget>[],
      _ => [_Message(text: '${l10n.readingSlip}…')],
    };
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.pagePadding,
        Dimens.gapL,
        Dimens.pagePadding,
        Dimens.pagePadding,
      ),
      children: children,
    );
  }

  Future<void> _editDescription(BuildContext context, SlipDraft draft) async {
    final bloc = context.read<SlipReviewBloc>();
    final text = await showDialog<String>(
      context: context,
      builder: (context) => TextInputDialog(
        title: context.l10n.descriptionTitle,
        initial: draft.transaction?.description ?? '',
      ),
    );
    if (text != null) bloc.add(SlipDescriptionChanged(text));
  }

  Future<void> _pickAccount(
    BuildContext context,
    SlipDraft draft,
    int index,
  ) async {
    final bloc = context.read<SlipReviewBloc>();
    final current = draft.transaction?.postings[index].account;
    if (current == null) return;
    final picked = await showDialog<String>(
      context: context,
      builder: (context) => ChoiceDialog(
        title: context.l10n.accountTitle,
        selected: current,
        options: [for (final account in draft.accounts) (account, account)],
      ),
    );
    if (picked != null) {
      bloc.add(SlipAccountChanged(posting: index, account: picked));
    }
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.text, this.isError = false});

  final String text;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TuiPanel(
      title: context.l10n.slipTitle,
      accent: true,
      padding: const EdgeInsets.all(Dimens.panelPadding),
      child: Row(
        spacing: Dimens.gapM,
        children: [
          if (!isError)
            const SizedBox.square(
              dimension: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: isError ? scheme.error : null),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    final bloc = context.read<SlipReviewBloc>();
    final (canSave, busy) = context.select(
      (SlipReviewBloc bloc) => (
        bloc.state.canSave,
        bloc.state.status == SlipReviewStatus.reading ||
            bloc.state.status == SlipReviewStatus.saving,
      ),
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.pagePadding,
            vertical: Dimens.gapS,
          ),
          child: Row(
            spacing: 6,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: TuiButton.action(
                  label: l10n.skipAction,
                  color: scheme.onSurface,
                  padding: 10,
                  onPressed: busy ? null : () => bloc.add(const SlipSkipped()),
                ),
              ),
              Expanded(
                child: TuiButton.primary(
                  label: l10n.saveNextAction,
                  onPressed: canSave
                      ? () => bloc.add(const SlipSaveRequested())
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
