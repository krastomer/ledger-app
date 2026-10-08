import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/domain/use_cases/transaction_detail_use_case.dart';
import 'package:ledger_app/ui/transaction_detail/bloc/transaction_detail_cubit.dart';
import 'package:ledger_app/ui/transaction_detail/view/transaction_detail_view.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';
import '../../../../testing/widget_harness.dart';

class _RejectingWrites extends FakeLedgerRepository {
  _RejectingWrites({super.accounts, super.transactions});

  @override
  Future<Result<void>> save(LedgerTransaction transaction) async =>
      Result.error(Exception('read only'));

  @override
  Future<Result<void>> delete(String id) async =>
      Result.error(Exception('read only'));
}

void main() {
  late FakeLedgerRepository ledger;
  late GoRouter router;

  setUp(() {
    ledger = FakeLedgerRepository(
      accounts: fixtureAccounts,
      transactions: fixtureTransactions,
    );
  });

  Future<void> pumpDetail(
    WidgetTester tester,
    String id, {
    bool load = true,
  }) async {
    final cubit = TransactionDetailCubit(
      id: id,
      transactionDetail: TransactionDetailUseCase(ledgerRepository: ledger),
      editTransaction: EditTransactionUseCase(ledgerRepository: ledger),
    );
    addTearDown(cubit.close);
    if (load) await cubit.load();
    router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: Text('journal')),
        ),
        GoRoute(
          path: '/detail',
          builder: (_, _) => BlocProvider<TransactionDetailCubit>.value(
            value: cubit,
            child: const TransactionDetailView(),
          ),
        ),
      ],
    );
    await pumpApp(tester, router: router);
    unawaited(router.push('/detail'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }

  testWidgets('shows a spinner until the entry has loaded', (tester) async {
    await pumpDetail(tester, 'rent', load: false);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('< copy >'), findsNothing);
  });

  testWidgets('says so when the entry no longer exists', (tester) async {
    await pumpDetail(tester, 'gone');

    expect(find.text('This entry no longer exists'), findsOneWidget);
    expect(find.text('< delete >'), findsNothing);
  });

  testWidgets('says so when the ledger cannot be read', (tester) async {
    ledger = FakeLedgerRepository(error: Exception('disk'));

    await pumpDetail(tester, 'rent');

    expect(find.text("Couldn't load your ledger"), findsOneWidget);
  });

  testWidgets('a pending entry can be confirmed', (tester) async {
    await pumpDetail(tester, 'rent');
    expect(find.text('! to review'), findsOneWidget);

    await tester.tap(find.text('< confirm >'));
    await tester.pumpAndSettle();

    expect(
      ledger.transactions.firstWhere((t) => t.id == 'rent').status,
      TransactionStatus.cleared,
    );
    expect(find.text('< confirm >'), findsNothing);
    expect(find.text('* cleared'), findsOneWidget);
  });

  testWidgets('a cleared entry has nothing to confirm', (tester) async {
    await pumpDetail(tester, 'lunch');

    expect(find.text('< confirm >'), findsNothing);
    expect(find.text('< delete >'), findsOneWidget);
  });

  testWidgets('deleting asks first and can be cancelled', (tester) async {
    await pumpDetail(tester, 'bts');

    await tester.tap(find.text('< delete >'));
    await tester.pumpAndSettle();
    expect(find.text('Delete this entry?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(ledger.transactions.map((t) => t.id), contains('bts'));
    expect(find.text('Delete this entry?'), findsNothing);
  });

  testWidgets('a confirmed delete removes the entry and goes back', (
    tester,
  ) async {
    await pumpDetail(tester, 'bts');

    await tester.tap(find.text('< delete >'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(ledger.transactions.map((t) => t.id), isNot(contains('bts')));
    expect(find.text('journal'), findsOneWidget);
  });

  testWidgets('copying puts the journal text on the clipboard', (tester) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map<Object?, Object?>)['text'] as String?;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    await pumpDetail(tester, 'lunch');

    await tester.tap(find.text('< copy >'));
    await tester.pump();

    expect(copied, startsWith('2026-09-28 * (REF-1) lunch'));
    expect(copied, contains('Expenses:Food:Lunch'));
    expect(find.text('Copied'), findsOneWidget);
  });

  testWidgets('tells the user each time a change cannot be saved', (
    tester,
  ) async {
    ledger = _RejectingWrites(
      accounts: fixtureAccounts,
      transactions: fixtureTransactions,
    );
    await pumpDetail(tester, 'rent');

    await tester.tap(find.text('< confirm >'));
    await tester.pump();
    expect(find.text("Couldn't save the change"), findsOneWidget);

    ScaffoldMessenger.of(tester.element(find.byType(TransactionDetailView)))
        .clearSnackBars();
    await tester.pumpAndSettle();
    expect(find.text("Couldn't save the change"), findsNothing);

    await tester.tap(find.text('< confirm >'));
    await tester.pump();
    expect(find.text("Couldn't save the change"), findsOneWidget);
    expect(find.text('! to review'), findsOneWidget);
  });

  testWidgets('the back button returns to the journal', (tester) async {
    await pumpDetail(tester, 'rent');

    await tester.tap(find.text('q'));
    await tester.pumpAndSettle();

    expect(find.text('journal'), findsOneWidget);
  });
}
