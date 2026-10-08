import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/routing/routes.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_dashed_line.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/ui/setup/widgets/setup_choice_row.dart';
import 'package:ledger_app/ui/setup/widgets/setup_scaffold.dart';

enum _Mode { startNew, importFile }

class SetupWelcomeView extends StatefulWidget {
  const SetupWelcomeView({super.key});

  @override
  State<SetupWelcomeView> createState() => _SetupWelcomeViewState();
}

class _SetupWelcomeViewState extends State<SetupWelcomeView> {
  _Mode _mode = _Mode.startNew;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return SetupScaffold(
      step: 2,
      footer: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: TuiButton.primary(
          label: l10n.continueAction,
          onPressed: () => context.push(switch (_mode) {
            _Mode.startNew => Routes.setupNew,
            _Mode.importFile => Routes.setupImport,
          }),
        ),
      ),
      children: [
        TuiPanel(
          title: l10n.setupTitle,
          accent: true,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.panelPadding,
            vertical: Dimens.gapS,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SetupChoiceRow(
                label: l10n.setupStartNew,
                hint: l10n.setupStartNewHint,
                selected: _mode == _Mode.startNew,
                onTap: () => setState(() => _mode = _Mode.startNew),
              ),
              TuiDashedLine(color: scheme.surfaceContainerHigh),
              SetupChoiceRow(
                label: l10n.setupImport,
                hint: l10n.setupImportHint,
                selected: _mode == _Mode.importFile,
                onTap: () => setState(() => _mode = _Mode.importFile),
              ),
            ],
          ),
        ),
        const SizedBox(height: Dimens.gapM),
        Text(
          '# ${l10n.dataStaysOnDevice.toLowerCase()}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
