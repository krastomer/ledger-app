import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/models/app_language.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';

import '../bloc/settings_cubit.dart';

import 'package:ledger_app/ui/core/widgets/choice_page.dart';

import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    return BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (previous, current) =>
          current.error != null && previous.error != current.error,
      listener: (context, state) {
        final message = switch (state.error) {
          SettingsError.saveFailed => l10n.settingsSaveFailed,
          null => null,
        };
        if (message == null) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              Dimens.pagePadding,
              Dimens.gapL,
              Dimens.pagePadding,
              Dimens.pagePadding,
            ),
            children: [
              TuiPanel(
                title: l10n.configFileTitle,
                accent: true,
                padding: const EdgeInsets.fromLTRB(
                  Dimens.panelPadding,
                  Dimens.gapS,
                  Dimens.panelPadding,
                  Dimens.gapXS,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: Dimens.gapXS,
                  children: [
                    SettingsSection(
                      title: l10n.settingsGeneral,
                      children: const [_LanguageTile(), _YearEraTile()],
                    ),
                    SettingsSection(
                      title: l10n.settingsDisplay,
                      children: const [
                        _HideOnLaunchTile(),
                        _ShowJournalTile(),
                        _HiddenAccountsTile(),
                        _HomeCardsTile(),
                      ],
                    ),
                    SettingsSection(
                      title: l10n.settingsStorage,
                      children: const [
                        _KeepSlipImagesTile(),
                        _BackupTile(),
                        _RestoreTile(),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimens.gapM),
              Text(
                '# ${l10n.dataStaysOnDevice.toLowerCase()}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final language = context.select(
      (SettingsCubit cubit) => cubit.state.settings.language,
    );
    return SettingsTile(
      label: l10n.settingsLanguage,
      value: _languageName(l10n, language),
      onTap: () async {
        final cubit = context.read<SettingsCubit>();
        final picked = await pickChoice<AppLanguage>(
          context,
          title: l10n.settingsLanguage,
          selected: language,
          options: [
            for (final option in AppLanguage.values)
              (option, _languageName(l10n, option)),
          ],
        );
        if (picked != null) await cubit.setLanguage(picked);
      },
    );
  }

  static String _languageName(AppLocalizations l10n, AppLanguage language) =>
      switch (language) {
        AppLanguage.th => l10n.languageThai,
        AppLanguage.en => l10n.languageEnglish,
      };
}

class _YearEraTile extends StatelessWidget {
  const _YearEraTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final yearEra = context.select(
      (SettingsCubit cubit) => cubit.state.settings.yearEra,
    );
    final today = DateTime.now();
    return SettingsTile(
      label: l10n.settingsYearFormat,
      value: _yearLabel(l10n, yearEra, today),
      onTap: () async {
        final cubit = context.read<SettingsCubit>();
        final picked = await pickChoice<YearEra>(
          context,
          title: l10n.settingsYearFormat,
          selected: yearEra,
          options: [
            for (final option in YearEra.values)
              (option, _yearLabel(l10n, option, today)),
          ],
        );
        if (picked != null) await cubit.setYearEra(picked);
      },
    );
  }

  static String _yearLabel(
    AppLocalizations l10n,
    YearEra yearEra,
    DateTime date,
  ) {
    final year = yearEra.yearOf(date);
    return switch (yearEra) {
      YearEra.buddhist => l10n.yearBuddhistEra(year),
      YearEra.gregorian => l10n.yearCommonEra(year),
    };
  }
}

class _HideOnLaunchTile extends StatelessWidget {
  const _HideOnLaunchTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final value = context.select(
      (SettingsCubit cubit) => cubit.state.settings.hideOnLaunch,
    );
    return SettingsSwitchTile(
      label: l10n.settingsHideOnLaunch,
      hint: l10n.settingsHideOnLaunchHint,
      value: value,
      onChanged: context.read<SettingsCubit>().setHideOnLaunch,
    );
  }
}

class _ShowJournalTile extends StatelessWidget {
  const _ShowJournalTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final value = context.select(
      (SettingsCubit cubit) => cubit.state.settings.showJournal,
    );
    return SettingsSwitchTile(
      label: l10n.settingsShowJournal,
      hint: l10n.settingsShowJournalHint,
      value: value,
      onChanged: context.read<SettingsCubit>().setShowJournal,
    );
  }
}

// Hidden accounts, home cards, backup and restore aren't built yet; their
// rows show fixed values and only say so when tapped.
const _homeCards = ['net_worth', 'inbox', 'month', 'recent'];

void _showComingSoon(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(context.l10n.comingSoon)));
}

class _HiddenAccountsTile extends StatelessWidget {
  const _HiddenAccountsTile();

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      label: context.l10n.settingsHiddenAccounts,
      value: '0',
      kind: SettingValueKind.literal,
      onTap: () => _showComingSoon(context),
    );
  }
}

class _HomeCardsTile extends StatelessWidget {
  const _HomeCardsTile();

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      label: context.l10n.settingsHomeCards,
      value: '[${_homeCards.join(', ')}]',
      kind: SettingValueKind.list,
      onTap: () => _showComingSoon(context),
    );
  }
}

class _KeepSlipImagesTile extends StatelessWidget {
  const _KeepSlipImagesTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final value = context.select(
      (SettingsCubit cubit) => cubit.state.settings.keepSlipImages,
    );
    return SettingsSwitchTile(
      label: l10n.settingsKeepSlipImages,
      hint: l10n.settingsKeepSlipImagesHint,
      value: value,
      onChanged: context.read<SettingsCubit>().setKeepSlipImages,
    );
  }
}

class _BackupTile extends StatelessWidget {
  const _BackupTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SettingsActionTile(
      actionLabel: l10n.backUpAction,
      onPressed: () => _showComingSoon(context),
      child: SettingKeyValue(
        label: l10n.settingsLastBackup,
        value: l10n.backupNever,
      ),
    );
  }
}

class _RestoreTile extends StatelessWidget {
  const _RestoreTile();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SettingsActionTile(
      actionLabel: l10n.restoreAction,
      onPressed: () => _showComingSoon(context),
      child: SettingComment(l10n.restoreReplacesData),
    );
  }
}
