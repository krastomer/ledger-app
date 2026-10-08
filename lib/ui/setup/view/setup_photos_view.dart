import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/domain/models/gallery_album.dart';
import 'package:ledger_app/domain/models/gallery_look_back.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/routing/routes.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_dashed_line.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';
import 'package:ledger_app/ui/settings/widgets/settings_tile.dart';

import '../bloc/setup_photos_cubit.dart';
import '../widgets/setup_chip_choice.dart';
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
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (previous, current) =>
              !previous.settings.syncGallery && current.settings.syncGallery,
          listener: (context, state) => context.read<SetupPhotosCubit>().load(),
        ),
        BlocListener<SetupPhotosCubit, SetupPhotosState>(
          listenWhen: (previous, current) =>
              previous.status != current.status &&
              current.status == SetupPhotosStatus.ready,
          listener: (context, state) {
            final settings = context.read<SettingsCubit>();
            if (settings.state.settings.galleryAlbumIds != null) return;
            settings.setGalleryAlbumIds([
              for (final album in state.albums)
                if (album.kind == GalleryAlbumKind.screenshots) album.id,
            ]);
          },
        ),
      ],
      child: SetupScaffold(
        step: 4,
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
              children: [_SyncGallerySwitch(), _Albums()],
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
      ),
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

class _Albums extends StatelessWidget {
  const _Albums();

  @override
  Widget build(BuildContext context) {
    final enabled = context.select(
      (SettingsCubit cubit) => cubit.state.settings.syncGallery,
    );
    if (!enabled) return const SizedBox.shrink();
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final photos = context.watch<SetupPhotosCubit>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TuiDashedLine(color: scheme.surfaceContainerHigh),
        switch (photos.status) {
          SetupPhotosStatus.idle ||
          SetupPhotosStatus.loading => _Note(l10n.setupAlbumsLoading),
          SetupPhotosStatus.noAccess => _Note(
            '${l10n.setupScanNoAccess}. ${l10n.setupScanNoAccessHint}',
            error: true,
          ),
          SetupPhotosStatus.failed => _Note(
            l10n.setupAlbumsFailed,
            error: true,
          ),
          SetupPhotosStatus.ready => _AlbumList(state: photos),
        },
      ],
    );
  }
}

class _Note extends StatelessWidget {
  const _Note(this.text, {this.error = false});

  final String text;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.gapS),
      child: Text(
        error ? '! $text' : '# $text',
        style: theme.textTheme.bodySmall?.copyWith(
          color: error
              ? theme.colorScheme.error
              : theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _AlbumList extends StatelessWidget {
  const _AlbumList({required this.state});

  final SetupPhotosState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final settings = context.watch<SettingsCubit>().state.settings;
    final saved = settings.galleryAlbumIds ?? const <String>[];
    final checked = {
      for (final album in state.albums)
        if (saved.contains(album.id)) album.id,
    };
    final lookBack = settings.galleryLookBack;
    final cubit = context.read<SettingsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (state.limited) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  '! ${l10n.setupLimitedAccess}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: scheme.primary,
                  ),
                ),
              ),
              TuiButton.action(
                label: l10n.setupSelectMore,
                onPressed: context.read<SetupPhotosCubit>().selectMore,
              ),
            ],
          ),
          TuiDashedLine(color: scheme.surfaceContainerHigh),
        ],
        _Heading(l10n.setupAlbumsHeading),
        for (final (index, album) in state.albums.indexed) ...[
          if (index > 0) TuiDashedLine(color: scheme.surfaceContainerHigh),
          _AlbumRow(
            album: album,
            checked: checked.contains(album.id),
            onTap: () => cubit.setGalleryAlbumIds([
              for (final id in saved)
                if (id != album.id) id,
              if (!checked.contains(album.id)) album.id,
            ]),
          ),
        ],
        if (checked.isEmpty) ...[
          TuiDashedLine(color: scheme.surfaceContainerHigh),
          _Note(l10n.setupNothingPicked(_period(l10n, lookBack))),
        ],
        TuiDashedLine(color: scheme.surfaceContainerHigh),
        SetupChipChoice<GalleryLookBack>(
          label: l10n.setupLookBack,
          selected: lookBack,
          options: [
            for (final option in GalleryLookBack.values)
              (option, _lookBackLabel(l10n, option)),
          ],
          onSelected: cubit.setGalleryLookBack,
        ),
      ],
    );
  }

  static String _lookBackLabel(AppLocalizations l10n, GalleryLookBack value) =>
      switch (value) {
        GalleryLookBack.days30 => l10n.setupLookBack30,
        GalleryLookBack.days90 => l10n.setupLookBack90,
        GalleryLookBack.all => l10n.setupLookBackAll,
      };

  static String _period(AppLocalizations l10n, GalleryLookBack value) =>
      _lookBackLabel(l10n, value).toLowerCase();
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.gapXS),
      child: Text(
        '# $text',
        style: theme.textTheme.bodySmall?.copyWith(
          fontStyle: FontStyle.italic,
          color: theme.colorScheme.onSurfaceVariant,
          height: 22 / 12,
        ),
      ),
    );
  }
}

class _AlbumRow extends StatelessWidget {
  const _AlbumRow({
    required this.album,
    required this.checked,
    required this.onTap,
  });

  final GalleryAlbum album;
  final bool checked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final hint = switch (album.kind) {
      GalleryAlbumKind.recents => l10n.setupAlbumRecentsHint,
      GalleryAlbumKind.screenshots => l10n.setupAlbumScreenshotsHint,
      GalleryAlbumKind.other when album.isSuggested =>
        l10n.setupAlbumSuggestedHint,
      GalleryAlbumKind.other => null,
    };
    final note = [l10n.setupAlbumPhotos(album.count), ?hint].join(' · ');
    return Semantics(
      checked: checked,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: Dimens.tapTarget),
          child: Row(
            spacing: Dimens.gapS,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: Dimens.gapS,
                      children: [
                        Flexible(
                          child: Text(
                            album.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: checked
                                  ? scheme.primary
                                  : scheme.onSurface,
                            ),
                          ),
                        ),
                        if (album.isSuggested) const _SuggestedTag(),
                      ],
                    ),
                    Text(
                      note,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              ExcludeSemantics(
                child: Text(
                  checked ? '[x]' : '[ ]',
                  style: TextStyle(
                    color: checked ? scheme.primary : scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestedTag extends StatelessWidget {
  const _SuggestedTag();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;
    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all(color: color)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.gapXS),
        child: Text(
          context.l10n.setupAlbumSuggested,
          style: theme.textTheme.labelSmall?.copyWith(color: color),
        ),
      ),
    );
  }
}
