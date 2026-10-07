import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/models/app_language.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/core/l10n.dart';
import 'package:ledger_app/ui/core/widgets/choice_page.dart';

import '../bloc/settings_cubit.dart';
import 'settings_tile.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

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

class YearEraTile extends StatelessWidget {
  const YearEraTile({super.key});

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
