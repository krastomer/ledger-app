import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/models/transaction_detail.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/utils/journal_format.dart';

import '../bloc/transaction_detail_cubit.dart';
import '../widgets/detail_panels.dart';

class TransactionDetailView extends StatelessWidget {
  const TransactionDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<TransactionDetailCubit>().state;
    final detail = state.detail;
    return BlocListener<TransactionDetailCubit, TransactionDetailState>(
      listener: (context, state) {
        if (state.status == TransactionDetailStatus.deleted) {
          Navigator.of(context).maybePop();
        } else if (state.error == TransactionDetailError.saveFailed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(l10n.changeFailed)));
        }
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
              Expanded(
                child: switch ((state.status, detail)) {
                  (_, final TransactionDetail detail) => _Panels(
                    detail: detail,
                  ),
                  (TransactionDetailStatus.loading, _) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  (TransactionDetailStatus.failure, _) => Center(
                    child: Text(l10n.loadFailed),
                  ),
                  _ => Center(child: Text(l10n.transactionNotFound)),
                },
              ),
              if (detail != null) _ActionBar(detail: detail),
            ],
          ),
        ),
      ),
    );
  }
}

class _Panels extends StatelessWidget {
  const _Panels({required this.detail});

  final TransactionDetail detail;

  @override
  Widget build(BuildContext context) {
    final transaction = detail.transaction;
    final code = transaction.code;
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.pagePadding,
        Dimens.gapL,
        Dimens.pagePadding,
        Dimens.pagePadding,
      ),
      children: [
        EntryHeaderPanel(transaction: transaction, summary: detail.summary),
        const SizedBox(height: Dimens.panelGap),
        PostingsPanel(transaction: transaction),
        if (code != null) ...[
          const SizedBox(height: Dimens.panelGap),
          SlipRefPanel(code: code),
        ],
        const SizedBox(height: Dimens.panelGap),
        JournalPanel(transaction: transaction),
      ],
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.detail});

  final TransactionDetail detail;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    final cubit = context.read<TransactionDetailCubit>();
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
            spacing: Dimens.gapXS,
            children: [
              TuiButton.action(
                label: l10n.copyAction,
                color: scheme.onSurface,
                onPressed: () => _copy(context),
              ),
              TuiButton.action(
                label: l10n.deleteAction,
                tooltip: l10n.deleteTransaction,
                color: scheme.error,
                onPressed: () => _delete(context, cubit),
              ),
              const Spacer(),
              if (detail.transaction.status == TransactionStatus.pending)
                TuiButton.primary(
                  label: l10n.confirmAction,
                  onPressed: cubit.confirm,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _copy(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final copied = context.l10n.copied;
    await Clipboard.setData(
      ClipboardData(text: formatJournalEntry(detail.transaction)),
    );
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(copied)));
  }

  Future<void> _delete(
    BuildContext context,
    TransactionDetailCubit cubit,
  ) async {
    final l10n = context.l10n;
    final material = MaterialLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(material.cancelButtonLabel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              l10n.deleteAction,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed ?? false) await cubit.delete();
  }
}
