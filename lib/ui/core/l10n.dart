import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  String get localeName => Localizations.localeOf(this).toLanguageTag();

  YearEra get yearEra =>
      select((SettingsCubit cubit) => cubit.state.settings.yearEra);
}
