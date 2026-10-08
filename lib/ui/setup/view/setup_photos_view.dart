import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/domain/models/gallery_sync_scope.dart';
import 'package:ledger_app/routing/routes.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_dashed_line.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';
import 'package:ledger_app/ui/settings/widgets/settings_tile.dart';

import '../widgets/setup_choice_row.dart';
import '../widgets/setup_scaffold.dart';

class SetupPhotosView extends StatelessWidget {
  const SetupPhotosView({super.key});

  Future<void> _finish(BuildContext context) async {
    await context.read<SettingsCubit>().completeSetup();
    if (context.mounted) context.go(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final syncGallery = context.select(
      (SettingsCubit cubit) => cubit.state.settings.syncGallery,
    );
    return SetupScaffold(
      step: 3,
      footer: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: TuiButton.primary(
          label: syncGallery ? l10n.setupPhotosScan : l10n.setupFinish,
          onPressed: syncGallery
              ? () => context.push(Routes.setupScan)
              : () => _finish(context),
        ),
      ),
      children: [
        TuiPanel(
          title: l10n.setupPhotosTitle,
          accent: true,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.panelPadding,
            vertical: Dimens.gapXS,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [_SyncGallerySwitch(), _ScopeChoices()],
          ),
        ),
        if (syncGallery) ...[
          const SizedBox(height: Dimens.panelGap),
          TuiPanel(
            title: l10n.setupHowTitle,
            background: Theme.of(context).colorScheme.surfaceContainerLow,
            child: Text(
              l10n.setupHowSteps,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
        const SizedBox(height: Dimens.gapM),
        SettingComment(l10n.setupPhotosHint, small: true),
      ],
    );
  }
}

class _SyncGallerySwitch extends StatelessWidget {
  const _SyncGallerySwitch();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final value = context.select(
      (SettingsCubit cubit) => cubit.state.settings.syncGallery,
    );
    return SettingsSwitchTile(
      label: l10n.setupSyncGallery,
      hint: l10n.setupSyncGalleryHint,
      value: value,
      onChanged: context.read<SettingsCubit>().setSyncGallery,
    );
  }
}

class _ScopeChoices extends StatelessWidget {
  const _ScopeChoices();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final (enabled, scope) = context.select(
      (SettingsCubit cubit) => (
        cubit.state.settings.syncGallery,
        cubit.state.settings.gallerySyncScope,
      ),
    );
    if (!enabled) return const SizedBox.shrink();
    final cubit = context.read<SettingsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TuiDashedLine(color: scheme.surfaceContainerHigh),
        SetupChoiceRow(
          label: l10n.setupScopeScreenshots,
          hint: l10n.setupScopeScreenshotsHint,
          selected: scope == GallerySyncScope.screenshots,
          minHeight: 52,
          onTap: () => cubit.setGallerySyncScope(GallerySyncScope.screenshots),
        ),
        TuiDashedLine(color: scheme.surfaceContainerHigh),
        SetupChoiceRow(
          label: l10n.setupScopeAll,
          hint: l10n.setupScopeAllHint,
          selected: scope == GallerySyncScope.all,
          minHeight: 52,
          onTap: () => cubit.setGallerySyncScope(GallerySyncScope.all),
        ),
      ],
    );
  }
}
