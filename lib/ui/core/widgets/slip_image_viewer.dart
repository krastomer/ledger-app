import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';

Future<void> showSlipImage(BuildContext context, String imagePath) =>
    showDialog<void>(
      context: context,
      useSafeArea: false,
      builder: (_) => SlipImageViewer(imagePath: imagePath),
    );

/// A slip image filling the screen; pinch to zoom.
class SlipImageViewer extends StatelessWidget {
  const SlipImageViewer({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    return Dialog.fullscreen(
      backgroundColor: scheme.surface,
      child: SafeArea(
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
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  padding: 0,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            Expanded(
              child: InteractiveViewer(
                maxScale: 5,
                child: Center(
                  child: Image.file(
                    File(imagePath),
                    semanticLabel: l10n.slipTitle,
                    errorBuilder: (_, _, _) => Text(
                      l10n.slipImageMissing,
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
