import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/core/themes/app_theme.dart';
import 'package:ledger_app/ui/core/widgets/choice_page.dart';

void main() {
  const options = [
    ('expenses:food', 'expenses:food'),
    ('expenses:rent', 'expenses:rent'),
    ('income:salary', 'income:salary'),
  ];

  Future<void> pumpPicker(
    WidgetTester tester, {
    required ValueChanged<String?> onResult,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () async => onResult(
              await pickChoice<String>(
                context,
                title: 'category',
                selected: 'expenses:rent',
                options: options,
                searchable: true,
              ),
            ),
            child: const Text('open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('groups options and filters them', (tester) async {
    await pumpPicker(tester, onResult: (_) {});

    expect(find.text('# expenses'), findsOneWidget);
    expect(find.text('# income'), findsOneWidget);
    expect(find.text('3/3'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'sal');
    await tester.pump();

    expect(find.text('# expenses'), findsNothing);
    expect(find.text('1/3'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'zzz');
    await tester.pump();

    expect(find.text('# no match'), findsOneWidget);
  });

  testWidgets('tapping a row returns it', (tester) async {
    String? result;
    await pumpPicker(tester, onResult: (value) => result = value);

    await tester.tap(find.textContaining('salary'));
    await tester.pumpAndSettle();

    expect(result, 'income:salary');
  });
}
