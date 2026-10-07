import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/domain/use_cases/transaction_detail_use_case.dart';
import 'package:ledger_app/l10n/app_localizations.dart';
import 'package:ledger_app/ui/core/themes/app_theme.dart';
import 'package:ledger_app/ui/core/widgets/slip_image_viewer.dart';
import 'package:ledger_app/ui/settings/bloc/settings_cubit.dart';
import 'package:ledger_app/ui/transaction_detail/bloc/transaction_detail_cubit.dart';
import 'package:ledger_app/ui/transaction_detail/view/transaction_detail_view.dart';
import 'package:ledger_app/ui/transaction_detail/widgets/detail_panels.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fakes/fake_settings_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  Future<void> pumpView(
    WidgetTester tester,
    String id, {
    AppSettings settings = const AppSettings(),
  }) async {
    final ledger = FakeLedgerRepository(
      accounts: fixtureAccounts,
      transactions: [
        for (final t in fixtureTransactions)
          t.id == 'rent' ? t.copyWith(slipImagePath: 'slip.jpg') : t,
      ],
    );
    final cubit = TransactionDetailCubit(
      id: id,
      transactionDetail: TransactionDetailUseCase(ledgerRepository: ledger),
      editTransaction: EditTransactionUseCase(ledgerRepository: ledger),
    );
    addTearDown(cubit.close);
    await cubit.load();
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => SettingsCubit(
                repository: FakeSettingsRepository(saved: settings),
                initial: settings,
              ),
            ),
            BlocProvider<TransactionDetailCubit>.value(value: cubit),
          ],
          child: const TransactionDetailView(),
        ),
      ),
    );
  }

  testWidgets('opens the slip image of an entry read from one', (tester) async {
    await pumpView(tester, 'rent');

    await tester.tap(find.text('< view image >'));
    await tester.pumpAndSettle();

    expect(find.byType(SlipImageViewer), findsOneWidget);
  });

  testWidgets('has no slip panel for an entry typed in by hand', (
    tester,
  ) async {
    await pumpView(tester, 'bts');

    expect(find.byType(SlipPanel), findsNothing);
  });

  testWidgets('shows the journal text by default', (tester) async {
    await pumpView(tester, 'rent');

    expect(find.byType(JournalPanel), findsOneWidget);
  });

  testWidgets('hides the journal text when turned off', (tester) async {
    await pumpView(
      tester,
      'rent',
      settings: const AppSettings(showJournal: false),
    );

    expect(find.byType(JournalPanel), findsNothing);
  });
}
