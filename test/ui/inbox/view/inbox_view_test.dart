import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/use_cases/edit_transaction_use_case.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/domain/use_cases/review_queue_use_case.dart';
import 'package:ledger_app/ui/inbox/bloc/inbox_cubit.dart';
import 'package:ledger_app/ui/inbox/view/inbox_view.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fakes/fake_slip_repository.dart';
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

class _FlakyLedger extends FakeLedgerRepository {
  _FlakyLedger({super.accounts, super.transactions});

  bool failing = true;

  @override
  Future<Result<List<LedgerTransaction>>> getTransactions() async =>
      failing ? Result.error(Exception('disk')) : super.getTransactions();
}

class _FailingPicker extends FakeSlipRepository {
  _FailingPicker() : super(const {});

  @override
  Future<Result<List<String>>> pickImages() async =>
      Result.error(Exception('no photos'));
}

void main() {
  late FakeLedgerRepository ledger;
  late InboxCubit cubit;

  final duplicate = fixtureTransaction('bts again', DateTime(2026, 9, 28), {
    'Expenses:Transport': thb(5000),
    'Liabilities:Credit card': thb(-5000),
  });
  final mystery = fixtureTransaction('mystery', DateTime(2026, 9, 27), {
    'Expenses:Uncategorized': thb(1200),
    'Assets:Bank:KBank': thb(-1200),
  });

  InboxCubit buildCubit({
    FakeSlipRepository? slips,
    required FakeLedgerRepository repository,
  }) => InboxCubit(
    reviewQueue: ReviewQueueUseCase(ledgerRepository: repository),
    editTransaction: EditTransactionUseCase(ledgerRepository: repository),
    importSlip: ImportSlipUseCase(
      slipRepository: slips ?? FakeSlipRepository(const {}),
      ledgerRepository: repository,
    ),
  );

  Future<void> pumpInbox(
    WidgetTester tester, {
    bool load = true,
    FakeSlipRepository? slips,
    List<String> paths = const ['/transaction/:id', '/review'],
  }) async {
    cubit = buildCubit(slips: slips, repository: ledger);
    addTearDown(cubit.close);
    if (load) await cubit.load();
    await pumpApp(
      tester,
      router: stubRouter(const InboxView(), paths: paths),
      wrap: (app) => BlocProvider<InboxCubit>.value(value: cubit, child: app),
    );
    await tester.pump();
  }

  setUp(() {
    ledger = FakeLedgerRepository(
      accounts: fixtureAccounts,
      transactions: [...fixtureTransactions, duplicate, mystery],
    );
  });

  testWidgets('shows a spinner until the queue has loaded', (tester) async {
    await pumpInbox(tester, load: false);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('lists every reason with its tag and open count', (tester) async {
    await pumpInbox(tester);

    expect(find.text('CONFIRM'), findsOneWidget);
    expect(find.text('DUP?'), findsOneWidget);
    expect(find.text('NO CAT'), findsOneWidget);
    expect(find.text('3 open'), findsOneWidget);
    expect(find.text('< confirm >'), findsOneWidget);
    expect(find.text('< drop one >'), findsOneWidget);
    expect(find.text('< categorize >'), findsOneWidget);
    expect(find.text('same day and postings as another entry'), findsOneWidget);
  });

  testWidgets('says so when there is nothing to review', (tester) async {
    ledger = FakeLedgerRepository(
      accounts: fixtureAccounts,
      transactions: fixtureTransactions.where((t) => t.id != 'rent').toList(),
    );

    await pumpInbox(tester);

    expect(find.text('Nothing to review'), findsOneWidget);
    expect(find.text('0 open'), findsOneWidget);
  });

  testWidgets('offers a retry when the ledger cannot be read', (tester) async {
    final flaky = _FlakyLedger(
      accounts: fixtureAccounts,
      transactions: fixtureTransactions,
    );
    ledger = flaky;
    await pumpInbox(tester);
    expect(find.text("Couldn't load your ledger"), findsOneWidget);

    flaky.failing = false;
    await tester.tap(find.text('< try again >'));
    await tester.pumpAndSettle();

    expect(find.text("Couldn't load your ledger"), findsNothing);
    expect(find.text('CONFIRM'), findsOneWidget);
  });

  testWidgets('confirming greys the item out as done', (tester) async {
    await pumpInbox(tester);

    await tester.tap(find.text('< confirm >'));
    await tester.pumpAndSettle();

    expect(find.text('[ ok ]'), findsOneWidget);
    expect(find.text('2 open'), findsOneWidget);
    expect(find.text('< confirm >'), findsNothing);
  });

  testWidgets('keeping a duplicate removes it from the open count', (
    tester,
  ) async {
    await pumpInbox(tester);

    await tester.tap(find.text('< keep >'));
    await tester.pumpAndSettle();

    expect(find.text('2 open'), findsOneWidget);
    expect(find.text('[ ok ]'), findsOneWidget);
    expect(ledger.transactions.map((t) => t.id), contains('bts again'));
  });

  testWidgets('dropping a duplicate deletes the later copy', (tester) async {
    await pumpInbox(tester);

    await tester.tap(find.text('< drop one >'));
    await tester.pumpAndSettle();

    expect(ledger.transactions.map((t) => t.id), isNot(contains('bts again')));
    expect(find.text('2 open'), findsOneWidget);
  });

  testWidgets('categorizing opens a picker without the placeholder', (
    tester,
  ) async {
    await pumpInbox(tester);

    await tester.tap(find.text('< categorize >'));
    await tester.pumpAndSettle();

    expect(find.text('category'), findsOneWidget);
    expect(
      find.textContaining('Uncategorized', findRichText: true),
      findsNothing,
    );

    await tester.tap(find.textContaining('Rent', findRichText: true));
    await tester.pumpAndSettle();

    final fixed = ledger.transactions.firstWhere((t) => t.id == 'mystery');
    expect(fixed.postings.first.account, 'Expenses:Rent');
    expect(find.text('[ ok ]'), findsOneWidget);
  });

  testWidgets('going back from the picker changes nothing', (tester) async {
    await pumpInbox(tester);

    await tester.tap(find.text('< categorize >'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('q'));
    await tester.pumpAndSettle();

    final unchanged = ledger.transactions.firstWhere((t) => t.id == 'mystery');
    expect(unchanged.postings.first.account, 'Expenses:Uncategorized');
    expect(find.text('NO CAT'), findsOneWidget);
  });

  testWidgets('opening a pending entry goes to its detail page', (
    tester,
  ) async {
    await pumpInbox(tester);

    await tester.tap(find.text('< open >'));
    await tester.pumpAndSettle();

    expect(find.text('at /transaction/rent'), findsOneWidget);
  });

  testWidgets('picked slip images open the review with their paths', (
    tester,
  ) async {
    await pumpInbox(
      tester,
      slips: FakeSlipRepository(const {}, picked: ['a.jpg', 'b.jpg']),
    );

    await tester.tap(find.text('< pick slips >'));
    await tester.pumpAndSettle();

    expect(find.text('at /review [a.jpg, b.jpg]'), findsOneWidget);
  });

  testWidgets('tells the user when photos cannot be opened', (tester) async {
    await pumpInbox(tester, slips: _FailingPicker());

    await tester.tap(find.text('< pick slips >'));
    await tester.pump();

    expect(find.text("Couldn't open your photos"), findsOneWidget);
  });

  testWidgets('tells the user when a change cannot be saved', (tester) async {
    ledger = _RejectingWrites(
      accounts: fixtureAccounts,
      transactions: fixtureTransactions,
    );
    await pumpInbox(tester);

    await tester.tap(find.text('< confirm >'));
    await tester.pump();

    expect(find.text("Couldn't save the change"), findsOneWidget);
    expect(find.text('< confirm >'), findsOneWidget);
  });
}
