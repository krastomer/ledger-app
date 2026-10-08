import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/domain/models/app_language.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/routing/routes.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/themes/dimens.dart';
import 'package:ledger_app/ui/core/widgets/tui_button.dart';
import 'package:ledger_app/ui/core/widgets/tui_panel.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';
import 'package:ledger_app/ui/settings/widgets/settings_section.dart';
import 'package:ledger_app/ui/settings/widgets/settings_tile.dart';

import '../widgets/setup_chip_choice.dart';
import '../widgets/setup_scaffold.dart';

class SetupSettingsView extends StatelessWidget {
  const SetupSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SetupScaffold(
      step: 1,
      canGoBack: false,
      footer: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: TuiButton.primary(
          label: l10n.continueAction,
          onPressed: () => context.push(Routes.setupStart),
        ),
      ),
      children: [
        TuiPanel(
          title: l10n.setupSettingsTitle,
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
                children: const [_LanguageChoice(), _YearEraChoice()],
              ),
              SettingsSection(
                title: l10n.setupPrivacy,
                children: const [
                  _HideOnLaunchSwitch(),
                  _KeepSlipImagesSwitch(),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: Dimens.gapM),
        SettingComment(l10n.setupChangeLater, small: true),
      ],
    );
  }
}

class _LanguageChoice extends StatelessWidget {
  const _LanguageChoice();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final language = context.select(
      (SettingsCubit cubit) => cubit.state.settings.language,
    );
    return SetupChipChoice<AppLanguage>(
      label: l10n.settingsLanguage,
      selected: language,
      options: [
        (AppLanguage.en, l10n.languageEnglish),
        (AppLanguage.th, l10n.languageThai),
      ],
      onSelected: context.read<SettingsCubit>().setLanguage,
    );
  }
}

class _YearEraChoice extends StatelessWidget {
  const _YearEraChoice();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final yearEra = context.select(
      (SettingsCubit cubit) => cubit.state.settings.yearEra,
    );
    final today = DateTime.now();
    return SetupChipChoice<YearEra>(
      label: l10n.settingsYearFormat,
      selected: yearEra,
      options: [
        (
          YearEra.gregorian,
          l10n.yearCommonEra(YearEra.gregorian.yearOf(today)),
        ),
        (
          YearEra.buddhist,
          l10n.yearBuddhistEra(YearEra.buddhist.yearOf(today)),
        ),
      ],
      onSelected: context.read<SettingsCubit>().setYearEra,
    );
  }
}

class _HideOnLaunchSwitch extends StatelessWidget {
  const _HideOnLaunchSwitch();

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

class _KeepSlipImagesSwitch extends StatelessWidget {
  const _KeepSlipImagesSwitch();

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
