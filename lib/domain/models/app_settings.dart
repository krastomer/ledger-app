import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_language.dart';
import 'year_era.dart';

part 'app_settings.freezed.dart';

@freezed
abstract class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default(AppLanguage.th) AppLanguage language,
    @Default(YearEra.buddhist) YearEra yearEra,

    /// Start with amounts masked on Home.
    @Default(false) bool hideOnLaunch,

    /// Show each entry's hledger text on its detail screen.
    @Default(true) bool showJournal,
    @Default(true) bool keepSlipImages,
  }) = _AppSettings;
}
