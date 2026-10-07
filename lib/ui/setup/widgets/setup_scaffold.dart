import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';

class SetupScaffold extends StatelessWidget {
  const SetupScaffold({
    super.key,
    required this.children,
    required this.footer,
    this.canGoBack = true,
  });

  final List<Widget> children;
  final Widget footer;
  final bool canGoBack;

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
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: canGoBack
                    ? TuiButton(
                        keyHint: 'q',
                        label: context.l10n.back,
                        tooltip: MaterialLocalizations.of(context)
                            .backButtonTooltip,
                        padding: 0,
                        onPressed: () => Navigator.of(context).maybePop(),
                      )
                    : const SizedBox(height: Dimens.tapTarget),
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
