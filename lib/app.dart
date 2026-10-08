import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/data/repositories/gallery/gallery_repository.dart';
import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/data/repositories/ledger_import/ledger_import_repository.dart';
import 'package:ledger_app/data/repositories/rules/rules_repository.dart';
import 'package:ledger_app/data/repositories/settings/settings_repository.dart';
import 'package:ledger_app/data/repositories/slip/slip_repository.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/core/themes/app_scroll_behavior.dart';
import 'package:ledger_app/ui/core/themes/app_theme.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.galleryRepository,
    required this.ledgerRepository,
    required this.ledgerImportRepository,
    required this.rulesRepository,
    required this.settingsRepository,
    required this.slipRepository,
    required this.initialSettings,
    required this.router,
  });

  final GalleryRepository galleryRepository;
  final LedgerRepository ledgerRepository;
  final LedgerImportRepository ledgerImportRepository;
  final RulesRepository rulesRepository;
  final SettingsRepository settingsRepository;
  final SlipRepository slipRepository;
  final AppSettings initialSettings;
  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GalleryRepository>.value(value: galleryRepository),
        RepositoryProvider<LedgerRepository>.value(value: ledgerRepository),
        RepositoryProvider<LedgerImportRepository>.value(
          value: ledgerImportRepository,
        ),
        RepositoryProvider<RulesRepository>.value(value: rulesRepository),
        RepositoryProvider<SettingsRepository>.value(value: settingsRepository),
        RepositoryProvider<SlipRepository>.value(value: slipRepository),
      ],
      child: BlocProvider(
        create: (context) =>
            SettingsCubit(repository: context.read(), initial: initialSettings),
        child: BlocSelector<SettingsCubit, SettingsState, Locale>(
          selector: (state) => Locale(state.settings.language.name),
          builder: (context, locale) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            theme: AppTheme.dark,
            scrollBehavior: const AppScrollBehavior(),
            builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: child ?? const SizedBox.shrink(),
            ),
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      ),
    );
  }
}
