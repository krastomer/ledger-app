import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/domain/models/ledger_check.dart';
import 'package:ledger_app/routing/routes.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/utils/date_format.dart';

import '../bloc/boot_cubit.dart';

const _banner = r'''
 _          _
| | ___  __| | __ _  ___ _ __
| |/ _ \/ _` |/ _` |/ _ \ '__|
| |  __/ (_| | (_| |  __/ |
|_|\___|\__,_|\__, |\___|_|
              |___/''';

class BootView extends StatelessWidget {
  const BootView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = context.l10n;
    final status = context.select((BootCubit cubit) => cubit.state.status);
    final small = theme.textTheme.bodySmall?.copyWith(
      color: scheme.onSurfaceVariant,
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.pagePadding,
            Dimens.gapS,
            Dimens.pagePadding,
            Dimens.gapL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.bootHeader, style: small),
                  Text(l10n.bootOnDevice, style: small),
                ],
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 28,
                      children: [
                        Semantics(
                          header: true,
                          label: 'ledger',
                          child: ExcludeSemantics(
                            child: Text(
                              _banner,
                              softWrap: false,
                              style: theme.textTheme.titleMedium?.copyWith(
                                height: 18 / 15,
                                color: scheme.primary,
                              ),
                            ),
                          ),
                        ),
                        const _BootLog(),
                      ],
                    ),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: status == BootStatus.checking
                        ? scheme.outlineVariant
                        : scheme.primary,
                  ),
                ),
                child: TuiButton.action(
                  label: l10n.continueAction,
                  onPressed: status == BootStatus.checking
                      ? null
                      : () => context.go(Routes.home),
                ),
              ),
              const SizedBox(height: Dimens.gapS),
              Text(
                '# ${l10n.dataStaysOnDevice.toLowerCase()}',
                textAlign: TextAlign.center,
                style: small,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum _Level { ok, warn, fail, wait }

class _BootLog extends StatelessWidget {
  const _BootLog();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.select((BootCubit cubit) => cubit.state);
    final check = state.check;
    final lines = switch ((state.status, check)) {
      (BootStatus.ready, final LedgerCheck check) => [
        (_Level.ok, l10n.bootOpened(check.transactionCount)),
        if ((check.firstMonth, check.lastMonth) case (
          final DateTime first,
          final DateTime last,
        ))
          (
            _Level.ok,
            l10n.bootParsed(formatIsoMonth(first), formatIsoMonth(last)),
          ),
        if (check.unbalancedCount == 0)
          (_Level.ok, l10n.bootBalanced)
        else
          (_Level.warn, l10n.bootUnbalanced(check.unbalancedCount)),
        (_Level.ok, l10n.bootOcr(_ocrEngine)),
        if (check.reviewCount == 0)
          (_Level.ok, l10n.nothingToReview)
        else
          (
            _Level.warn,
            '${check.reviewCount} ${l10n.itemsNeedReview(check.reviewCount)}',
          ),
      ],
      (BootStatus.failed, _) => [(_Level.fail, l10n.bootFailed)],
      _ => [(_Level.wait, l10n.bootOpening)],
    };
    return Semantics(
      liveRegion: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (level, text) in lines) _LogLine(level: level, text: text),
          const _Prompt(),
        ],
      ),
    );
  }

  static String get _ocrEngine => switch (defaultTargetPlatform) {
    TargetPlatform.iOS || TargetPlatform.macOS => 'Apple Vision',
    _ => 'Tesseract',
  };
}

class _LogLine extends StatelessWidget {
  const _LogLine({required this.level, required this.text});

  final _Level level;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final (label, color) = switch (level) {
      _Level.ok => ('  OK  ', scheme.tertiary),
      _Level.warn => (' WARN ', scheme.primary),
      _Level.fail => (' FAIL ', scheme.error),
      _Level.wait => (' .... ', scheme.onSurfaceVariant),
    };
    final muted = TextStyle(color: scheme.onSurfaceVariant);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: '[', style: muted),
          TextSpan(
            text: label,
            style: TextStyle(color: color),
          ),
          TextSpan(text: '] ', style: muted),
          TextSpan(text: text),
        ],
      ),
      style: theme.textTheme.bodySmall?.copyWith(height: 22 / 12),
    );
  }
}

class _Prompt extends StatelessWidget {
  const _Prompt();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ExcludeSemantics(
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          spacing: Dimens.gapS,
          children: [
            Text(r'$', style: TextStyle(color: scheme.primary)),
            SizedBox(
              width: 8,
              height: 16,
              child: ColoredBox(color: scheme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
