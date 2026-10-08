import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/repositories/rules/rules_repository.dart';
import 'package:ledger_app/domain/models/app_language.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/models/year_era.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/core/themes/app_theme.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';
import 'package:ledger_app/ui/settings/view/settings_view.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/fakes/fake_rules_repository.dart';

class _MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

void main() {
  late _MockSettingsCubit cubit;
  final today = DateTime.now();
  final buddhistYear = YearEra.buddhist.yearOf(today);
  final gregorianYear = YearEra.gregorian.yearOf(today);

  setUp(() {
    cubit = _MockSettingsCubit();
    when(() => cubit.setLanguage(any())).thenAnswer((_) async {});
    when(() => cubit.setYearEra(any())).thenAnswer((_) async {});
    when(() => cubit.setHideOnLaunch(any())).thenAnswer((_) async {});
  });

  setUpAll(() {
    registerFallbackValue(AppLanguage.th);
    registerFallbackValue(YearEra.buddhist);
  });

  Future<void> pumpApp(WidgetTester tester, Locale locale) => tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.dark,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: RepositoryProvider<RulesRepository>.value(
        value: FakeRulesRepository(),
        child: BlocProvider<SettingsCubit>.value(
          value: cubit,
          child: const SettingsView(),
        ),
      ),
    ),
  );

  Future<void> pumpView(
    WidgetTester tester, {
    AppSettings settings = const AppSettings(),
    Locale locale = const Locale('th'),
  }) async {
    when(() => cubit.state).thenReturn(SettingsState(settings: settings));
    await pumpApp(tester, locale);
  }

  testWidgets('shows the current language and year format', (tester) async {
    await pumpView(tester);

    expect(find.text('# ทั่วไป'), findsOneWidget);
    expect(find.text('ภาษา = "ไทย"'), findsOneWidget);
    expect(find.text('การแสดงปี = "พ.ศ. $buddhistYear"'), findsOneWidget);
  });

  testWidgets('shows English labels', (tester) async {
    await pumpView(
      tester,
      settings: const AppSettings(
        language: AppLanguage.en,
        yearEra: YearEra.gregorian,
      ),
      locale: const Locale('en'),
    );

    expect(find.text('language = "English"'), findsOneWidget);
    expect(find.text('year_format = "A.D. $gregorianYear"'), findsOneWidget);
  });

  testWidgets('picking a language updates the setting', (tester) async {
    await pumpView(tester);

    await tester.tap(find.textContaining('ภาษา'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    verify(() => cubit.setLanguage(AppLanguage.en)).called(1);
  });

  testWidgets('picking a year format updates the setting', (tester) async {
    await pumpView(tester);

    await tester.tap(find.textContaining('การแสดงปี'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ค.ศ. $gregorianYear'));
    await tester.pumpAndSettle();

    verify(() => cubit.setYearEra(YearEra.gregorian)).called(1);
  });

  testWidgets('shows a message when saving fails', (tester) async {
    whenListen(
      cubit,
      Stream.value(
        const SettingsState(
          settings: AppSettings(),
          error: SettingsError.saveFailed,
        ),
      ),
      initialState: const SettingsState(settings: AppSettings()),
    );

    await pumpApp(tester, const Locale('th'));
    await tester.pump();

    expect(find.text('บันทึกการตั้งค่าไม่สำเร็จ'), findsOneWidget);
  });

  testWidgets('lists the display and storage settings', (tester) async {
    await pumpView(tester, locale: const Locale('en'));

    expect(find.text('# display'), findsOneWidget);
    expect(find.text('hide_on_launch = false'), findsOneWidget);
    expect(find.text('# amounts on home start hidden'), findsOneWidget);
    expect(find.text('show_journal = true'), findsOneWidget);
    expect(find.text('hidden_accounts = 0'), findsOneWidget);
    expect(
      find.text('home_cards = [net_worth, inbox, month, recent]'),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(find.text('< restore >'), 100);
    expect(find.text('# storage'), findsOneWidget);
    expect(find.text('keep_slip_images = true'), findsOneWidget);
    expect(find.text('backup.last = "never"'), findsOneWidget);
  });

  testWidgets('tapping a switch flips the setting', (tester) async {
    await pumpView(tester, locale: const Locale('en'));

    await tester.tap(find.text('hide_on_launch = false'));

    verify(() => cubit.setHideOnLaunch(true)).called(1);
  });

  testWidgets('settings that are not built yet say so', (tester) async {
    await pumpView(tester, locale: const Locale('en'));

    await tester.tap(find.text('hidden_accounts = 0'));
    await tester.pump();

    expect(find.text('Coming soon'), findsOneWidget);
  });
}
