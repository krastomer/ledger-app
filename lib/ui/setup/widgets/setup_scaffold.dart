import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';

class SetupScaffold extends StatelessWidget {
  const SetupScaffold({
    super.key,
    required this.children,
    required this.footer,
    required this.step,
    this.canGoBack = true,
    this.backLabel,
  });

  final List<Widget> children;
  final Widget footer;
  final int step;
  final bool canGoBack;
  final String? backLabel;

  static const stepCount = 3;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
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
              child: Row(
                children: [
                  if (canGoBack)
                    TuiButton(
                      keyHint: 'q',
                      label: backLabel ?? context.l10n.back,
                      tooltip: MaterialLocalizations.of(context)
                          .backButtonTooltip,
                      padding: 0,
                      onPressed: () => Navigator.of(context).maybePop(),
                    )
                  else
                    const SizedBox(height: Dimens.tapTarget),
                  const Spacer(),
                  Text(
                    context.l10n.setupStep(step, stepCount),
                    style: TextStyle(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  Dimens.pagePadding,
                  Dimens.gapL,
                  Dimens.pagePadding,
                  Dimens.pagePadding,
                ),
                children: children,
              ),
            ),
            DecoratedBox(
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
                  child: footer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
