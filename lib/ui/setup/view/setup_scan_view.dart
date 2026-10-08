import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/domain/models/gallery_sync_scope.dart';
import 'package:ledger_app/routing/routes.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_bar.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';
import 'package:ledger_app/ui/settings/widgets/settings_tile.dart';

import '../bloc/setup_scan_cubit.dart';
import '../widgets/setup_log_line.dart';
import '../widgets/setup_scaffold.dart';
import '../widgets/setup_scan_listener.dart';
import 'setup_found_view.dart';

class SetupScanView extends StatelessWidget {
  const SetupScanView({super.key});

  @override
  Widget build(BuildContext context) {
    final inReview = context.select(
      (SetupScanCubit cubit) => cubit.state.inReview,
    );
    return SetupScanListener(
      child: inReview ? const SetupFoundView() : const _ScanningView(),
    );
  }
}

class _ScanningView extends StatelessWidget {
  const _ScanningView();

  Future<void> _finish(BuildContext context) async {
    await context.read<SettingsCubit>().completeSetup();
    if (context.mounted) context.go(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<SetupScanCubit>().state;
    final failed = state.phase == SetupScanPhase.failed;
    final scanned = state.phase == SetupScanPhase.scanned;
    final found = state.found.length;
    return SetupScaffold(
      step: 3,
      backLabel: l10n.setupScanCancel,
      footer: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: switch (state.phase) {
          SetupScanPhase.scanned when found > 0 => TuiButton.primary(
            label: l10n.setupScanReview(found),
            onPressed: context.read<SetupScanCubit>().review,
          ),
          SetupScanPhase.scanned || SetupScanPhase.failed => TuiButton.primary(
            label: l10n.setupFinish,
            onPressed: () => _finish(context),
          ),
          _ => TuiButton.action(label: l10n.setupScanScanning, onPressed: null),
        },
      ),
      children: [
        TuiPanel(
          title: l10n.setupScanTitle,
          accent: true,
          padding: const EdgeInsets.all(Dimens.panelPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: Dimens.gapM,
            children: [
              TuiBar(
                color: Theme.of(context).colorScheme.primary,
                fraction: state.toCheck == 0
                    ? (scanned ? 1 : 0)
                    : state.checked / state.toCheck,
              ),
              _ScanLog(state: state),
            ],
          ),
        ),
        const SizedBox(height: Dimens.gapM),
        SettingComment(
          failed ? _failedHint(context, state) : l10n.setupScanHint,
          small: true,
        ),
      ],
    );
  }

  static String _failedHint(BuildContext context, SetupScanState state) =>
      state.error == SetupScanError.noAccess
      ? context.l10n.setupScanNoAccessHint
      : context.l10n.setupScanFailed;
}

class _ScanLog extends StatelessWidget {
  const _ScanLog({required this.state});

  final SetupScanState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scope = context.select(
      (SettingsCubit cubit) => cubit.state.settings.gallerySyncScope,
    );
    final scanning = state.phase == SetupScanPhase.scanning;
    final scanned = state.phase == SetupScanPhase.scanned;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.phase == SetupScanPhase.failed)
          SetupLogLine(
            level: SetupLogLevel.fail,
            text: state.error == SetupScanError.noAccess
                ? l10n.setupScanNoAccess
                : l10n.setupScanFailed,
          )
        else if (state.phase == SetupScanPhase.starting)
          SetupLogLine(
            level: SetupLogLevel.working,
            text: l10n.setupScanScanning,
          )
        else ...[
          SetupLogLine(
            level: SetupLogLevel.ok,
            text: l10n.setupScanLibrary(state.libraryCount),
          ),
          SetupLogLine(
            level: SetupLogLevel.ok,
            text: switch (scope) {
              GallerySyncScope.screenshots => l10n.setupScanToCheckScreenshots(
                state.toCheck,
              ),
              GallerySyncScope.all => l10n.setupScanToCheckAll(state.toCheck),
            },
          ),
          SetupLogLine(
            level: scanning ? SetupLogLevel.working : SetupLogLevel.ok,
            text: l10n.setupScanRead(state.checked, state.toCheck),
          ),
          if (scanned)
            SetupLogLine(
              level: SetupLogLevel.ok,
              text: l10n.setupScanFound(state.found.length),
            ),
        ],
      ],
    );
  }
}
