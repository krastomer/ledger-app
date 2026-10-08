import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/domain/models/app_language.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/core/themes/app_theme.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';

import 'fakes/fake_settings_repository.dart';

const englishSettings = AppSettings(
  language: AppLanguage.en,
  yearEra: YearEra.gregorian,
);

/// Pumps [home] (or [router]) in the app theme and localization with a
/// [SettingsCubit] above it. [wrap] puts providers above the whole app, so
/// routes pushed later can read them.
Future<void> pumpApp(
  WidgetTester tester, {
  Widget? home,
  GoRouter? router,
  Widget Function(Widget app)? wrap,
  AppSettings settings = englishSettings,
  FakeSettingsRepository? settingsRepository,
  double textScale = 1,
}) async {
  assert((home == null) != (router == null), 'pass either home or router');
  Widget builder(BuildContext context, Widget? child) =>
      MediaQuery.withClampedTextScaling(
        minScaleFactor: textScale,
        maxScaleFactor: textScale,
        child: child ?? const SizedBox.shrink(),
      );
  final locale = Locale(settings.language.name);
  final app = router == null
      ? MaterialApp(
          theme: AppTheme.dark,
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: builder,
          home: home,
        )
      : MaterialApp.router(
          theme: AppTheme.dark,
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: builder,
          routerConfig: router,
        );
  await tester.pumpWidget(
    BlocProvider(
      create: (_) => SettingsCubit(
        repository:
            settingsRepository ?? FakeSettingsRepository(saved: settings),
        initial: settings,
      ),
      child: wrap == null ? app : wrap(app),
    ),
  );
}

/// A router whose [routes] other than `/` just print their location.
GoRouter stubRouter(Widget home, {List<String> paths = const []}) => GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, _) => home),
    for (final path in paths)
      GoRoute(
        path: path,
        builder: (_, state) => Text(
          'at ${state.uri} ${state.extra ?? ''}'.trim(),
          textDirection: TextDirection.ltr,
        ),
      ),
  ],
);
