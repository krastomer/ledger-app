import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_language.dart';
import 'gallery_sync_scope.dart';
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

    /// Look for new slips in the photo library.
    @Default(false) bool syncGallery,
    @Default(GallerySyncScope.screenshots) GallerySyncScope gallerySyncScope,

    /// False until the first-run setup has created or imported a ledger.
    @Default(false) bool setupComplete,
  }) = _AppSettings;
}
