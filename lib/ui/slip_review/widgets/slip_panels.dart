import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/domain/models/slip.dart';
import 'package:ledger_app/domain/models/slip_draft.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/amount_text.dart';
import 'package:ledger_app/ui/core/widgets/slip_thumbnail.dart';
import 'package:ledger_app/ui/core/widgets/tui_dashed_line.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/utils/date_format.dart';

const _labelWidth = 56.0;

/// The app each slip comes from, as its users know it.
String slipSourceName(SlipSource source) => switch (source) {
  SlipSource.kbank => 'K PLUS',
  SlipSource.scb => 'SCB EASY',
  SlipSource.kkp => 'KKP MOBILE',
  SlipSource.dime => 'Dime!',
};

String _kindName(AppLocalizations l10n, SlipKind kind) => switch (kind) {
  SlipKind.transfer => l10n.slipKindTransfer,
  SlipKind.payment => l10n.slipKindPayment,
  SlipKind.buy => l10n.slipKindBuy,
  SlipKind.sell => l10n.slipKindSell,
};

/// The image next to what was read off it.
class SlipSummaryPanel extends StatelessWidget {
  const SlipSummaryPanel({super.key, required this.draft});

  final SlipDraft draft;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final slip = draft.parsed.slip;
    final transaction = draft.transaction;
    final amount = transaction?.postings.first.amount;
    final time = transaction?.time;
    final duplicate = draft.duplicate;
    return TuiPanel(
      title: l10n.slipTitle,
      accent: true,
      trailing:
          '${slipSourceName(slip.source)} · ${_kindName(l10n, slip.kind)}',
      padding: const EdgeInsets.all(Dimens.panelPadding),
      child: Row(
        spacing: Dimens.gapM,
        children: [
          SlipThumbnail(imagePath: draft.imagePath),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 2,
              children: [
                _Fact(
                  label: l10n.amountLabel,
                  child: amount == null
                      ? Text('--', style: TextStyle(color: scheme.error))
                      : AmountText(amount, style: theme.textTheme.titleLarge),
                ),
                _Fact(
                  label: l10n.dateLabel,
                  child: Text(
                    transaction == null
                        ? '--'
                        : [
                            formatIsoDate(transaction.date),
                            if (time != null) formatTime(time),
                          ].join(' '),
                  ),
                ),
                _Fact(label: l10n.engineLabel, child: Text(_engine)),
                _Fact(
                  label: l10n.dupLabel,
                  child: Text(
                    duplicate == null
                        ? l10n.dupNone
                        : l10n.dupFound(formatMonthDay(duplicate.date)),
                    style: TextStyle(
                      color: duplicate == null ? scheme.tertiary : scheme.error,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String get _engine => switch (defaultTargetPlatform) {
    TargetPlatform.iOS || TargetPlatform.macOS => 'vision · local',
    _ => 'tesseract · local',
  };
}

class _Fact extends StatelessWidget {
  const _Fact({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Dimens.gapS,
      children: [
        SizedBox(
          width: _labelWidth,
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}

/// Each field read off the slip, marked `ok`, `chk` (worth a look) or
/// `--` (not on this slip).
class SlipFieldsPanel extends StatelessWidget {
  const SlipFieldsPanel({super.key, required this.draft, this.onEditPayee});

  final SlipDraft draft;
  final VoidCallback? onEditPayee;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final slip = draft.parsed.slip;
    final order = slip.order;
    final rows = switch (slip.kind) {
      SlipKind.transfer || SlipKind.payment => [
        _FieldRow(
          label: l10n.fromLabel,
          value: slip.from?.name,
          detail: slip.from?.account,
          check: draft.checkOf(SlipField.from),
        ),
        _FieldRow(
          label: l10n.toLabel,
          value: slip.to?.name,
          detail: slip.to?.account,
          check: draft.checkOf(SlipField.to),
          onTap: onEditPayee,
        ),
      ],
      SlipKind.buy || SlipKind.sell => [
        _FieldRow(
          label: order?.symbol ?? '--',
          value: [?order?.quantity, ?order?.unit].join(' '),
          check: draft.checkOf(SlipField.quantity),
        ),
      ],
    };
    return TuiPanel(
      title: l10n.fieldsTitle,
      trailing: 'stat',
      padding: const EdgeInsets.fromLTRB(
        Dimens.panelPadding,
        Dimens.gapXS,
        Dimens.panelPadding,
        Dimens.gapXS,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final row in [
            ...rows,
            _FieldRow(
              label: l10n.refLabel,
              value: slip.reference,
              check: draft.checkOf(SlipField.reference),
            ),
            _FieldRow(
              label: l10n.feeLabel,
              value: slip.fee?.toString(),
              check: draft.checkOf(SlipField.fee),
            ),
          ].indexed) ...[if (row.$1 > 0) const TuiDashedLine(), row.$2],
        ],
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({
    required this.label,
    required this.value,
    required this.check,
    this.detail,
    this.onTap,
  });

  final String label;
  final String? value;
  final String? detail;
  final SlipFieldCheck check;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final muted = TextStyle(color: scheme.onSurfaceVariant);
    final small = theme.textTheme.bodySmall;
    final detail = this.detail;
    final (stat, statColor) = switch (check) {
      SlipFieldCheck.ok => ('ok', scheme.tertiary),
      SlipFieldCheck.check => ('chk', scheme.error),
      SlipFieldCheck.absent => ('--', scheme.onSurfaceVariant),
    };
    final row = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 36),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.gapXS),
        child: Row(
          spacing: Dimens.gapS,
          children: [
            SizedBox(
              width: _labelWidth,
              child: Text(label, style: muted),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value ?? l10n.notOnSlip,
                    style: value == null ? muted : null,
                  ),
                  if (detail != null)
                    Text(
                      detail,
                      style: small?.copyWith(color: scheme.onSurfaceVariant),
                    ),
                  if (check == SlipFieldCheck.check && value != null)
                    Text(
                      '! ${l10n.unclearCheck}',
                      style: small?.copyWith(color: scheme.error),
                    ),
                ],
              ),
            ),
            Text(
              stat,
              style: TextStyle(
                color: statColor,
                fontWeight: check == SlipFieldCheck.check
                    ? FontWeight.w600
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
    final onTap = this.onTap;
    return onTap == null ? row : InkWell(onTap: onTap, child: row);
  }
}

/// The entry saving will write, line by line; each line can be changed.
class WillWritePanel extends StatelessWidget {
  const WillWritePanel({
    super.key,
    required this.draft,
    required this.onEditDescription,
    required this.onPickAccount,
  });

  final SlipDraft draft;
  final VoidCallback onEditDescription;
  final ValueChanged<int> onPickAccount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final transaction = draft.transaction;
    final source = slipSourceName(draft.parsed.slip.source);
    return TuiPanel(
      title: l10n.willWriteTitle,
      accent: true,
      background: scheme.surfaceContainerLow,
      padding: const EdgeInsets.fromLTRB(
        Dimens.panelPadding,
        Dimens.gapXS,
        Dimens.panelPadding,
        0,
      ),
      child: transaction == null
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.gapM),
              child: Text(
                l10n.slipNoAmount,
                style: TextStyle(color: scheme.error),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _EditableLine(
                  onTap: onEditDescription,
                  divider: false,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: formatIsoDate(transaction.date),
                          style: TextStyle(color: scheme.tertiary),
                        ),
                        if (transaction.status == TransactionStatus.pending)
                          TextSpan(
                            text: ' !',
                            style: TextStyle(color: scheme.error),
                          ),
                        TextSpan(text: ' ${transaction.description}'),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                for (final (index, posting) in transaction.postings.indexed)
                  _EditableLine(
                    onTap: () => onPickAccount(index),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            spacing: Dimens.gapS,
                            children: [
                              Expanded(
                                child: Text(
                                  posting.account,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (index < transaction.postings.length - 1)
                                AmountText(posting.amount),
                            ],
                          ),
                          if (switch (posting.account) {
                                final a when a == draft.sourceAccount =>
                                  l10n.hintFromSlip(source),
                                ImportSlipUseCase.fees => null,
                                ImportSlipUseCase.uncategorized =>
                                  l10n.hintPickCategory,
                                _ when draft.categoryFromHistory =>
                                  l10n.hintFromHistory,
                                _ => null,
                              }
                              case final hint?)
                            Text(
                              '# $hint',
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontStyle: FontStyle.italic,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _EditableLine extends StatelessWidget {
  const _EditableLine({
    required this.onTap,
    required this.child,
    this.divider = true,
  });

  final VoidCallback onTap;
  final Widget child;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: divider
              ? Border(top: BorderSide(color: scheme.surfaceContainerHigh))
              : null,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: Dimens.tapTarget),
          child: Row(
            spacing: Dimens.gapS,
            children: [
              Expanded(child: child),
              ExcludeSemantics(
                child: Text(
                  '>',
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
