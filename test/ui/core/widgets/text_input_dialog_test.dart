import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/ui/core/widgets/text_input_dialog.dart';

import '../../../../testing/widget_harness.dart';

void main() {
  Future<void> pumpOpener(
    WidgetTester tester,
    ValueChanged<String?> onResult, {
    String initial = '',
  }) async {
    await pumpApp(
      tester,
      home: Builder(
        builder: (context) => Scaffold(
          body: TextButton(
            onPressed: () async => onResult(
              await showDialog<String>(
                context: context,
                builder: (_) =>
                    TextInputDialog(title: 'Description', initial: initial),
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

  testWidgets('starts with the text it was given', (tester) async {
    await pumpOpener(tester, (_) {}, initial: 'Rent');

    expect(find.text('Description'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Rent'), findsOneWidget);
  });

  testWidgets('OK returns what was typed', (tester) async {
    String? result;
    await pumpOpener(tester, (value) => result = value);

    await tester.enterText(find.byType(TextField), 'Landlord');
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(result, 'Landlord');
  });

  testWidgets('the keyboard "done" returns it too', (tester) async {
    String? result;
    await pumpOpener(tester, (value) => result = value);

    await tester.enterText(find.byType(TextField), 'Landlord');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    expect(result, 'Landlord');
  });

  testWidgets('Cancel returns nothing', (tester) async {
    String? result = 'untouched';
    await pumpOpener(tester, (value) => result = value, initial: 'Rent');

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(result, isNull);
  });
}
