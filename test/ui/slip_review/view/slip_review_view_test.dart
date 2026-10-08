import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/money.dart' as slip_money;
import 'package:ledger_app/domain/models/posting.dart';
import 'package:ledger_app/domain/models/slip.dart';
import 'package:ledger_app/domain/models/slip_draft.dart';
import 'package:ledger_app/domain/models/slip_party.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/ui/slip_review/bloc/slip_review_bloc.dart';
import 'package:ledger_app/ui/slip_review/view/slip_review_view.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/fixtures/ledger_fixtures.dart';
import '../../../../testing/fixtures/slip_draft_fixtures.dart';
import '../../../../testing/widget_harness.dart';

class _MockSlipReviewBloc extends MockBloc<SlipReviewEvent, SlipReviewState>
    implements SlipReviewBloc {}

void main() {
  late _MockSlipReviewBloc bloc;

  setUpAll(() => registerFallbackValue(const SlipSkipped()));

  setUp(() => bloc = _MockSlipReviewBloc());

  LedgerTransaction entry({String description = 'Sample Property Co.'}) =>
      LedgerTransaction(
        id: 'new',
        date: DateTime(2026, 9, 29),
        time: const Duration(hours: 9, minutes: 15),
        description: description,
        status: TransactionStatus.pending,
        code: 'REF-NEW',
        postings: [
          Posting(account: 'Expenses:Uncategorized', amount: thb(850000)),
          Posting(account: 'Assets:Bank:KBank', amount: thb(-850000)),
        ],
      );

  SlipDraft draft({
    LedgerTransaction? transaction,
    LedgerTransaction? duplicate,
    ParsedSlip? parsed,
    bool fromHistory = false,
  }) => SlipDraft(
    imagePath: '/missing/slip.jpg',
    parsed: parsed ?? transferSlip(),
    transaction: transaction ?? entry(),
    duplicate: duplicate,
    sourceAccount: 'Assets:Bank:KBank',
    categoryFromHistory: fromHistory,
    accounts: const [
      'Assets:Bank:KBank',
      'Expenses:Food',
      'Expenses:Rent',
      'Expenses:Uncategorized',
    ],
  );

  SlipReviewState ready(SlipDraft draft, {int index = 0, int count = 2}) =>
      SlipReviewState(
        imagePaths: [for (var i = 0; i < count; i++) 'slip-$i.jpg'],
        index: index,
        status: SlipReviewStatus.ready,
        draft: draft,
      );

  Future<void> pumpReview(
    WidgetTester tester,
    SlipReviewState state, {
    Stream<SlipReviewState>? states,
  }) async {
    whenListen(
      bloc,
      states ?? const Stream<SlipReviewState>.empty(),
      initialState: state,
    );
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: Text('home')),
        ),
        GoRoute(path: '/review', builder: (_, _) => const SlipReviewView()),
      ],
    );
    await pumpApp(
      tester,
      router: router,
      wrap: (app) =>
          BlocProvider<SlipReviewBloc>.value(value: bloc, child: app),
    );
    unawaited(router.push('/review'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }

  testWidgets('shows a progress line and a spinner while reading', (
    tester,
  ) async {
    await pumpReview(
      tester,
      const SlipReviewState(imagePaths: ['a.jpg', 'b.jpg', 'c.jpg']),
    );

    expect(find.text('reading slip…'), findsOneWidget);
    expect(find.text('1/3'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('says when a slip cannot be read, and can still skip it', (
    tester,
  ) async {
    await pumpReview(
      tester,
      const SlipReviewState(
        imagePaths: ['a.jpg', 'b.jpg'],
        status: SlipReviewStatus.unreadable,
      ),
    );

    expect(find.text("Couldn't read this slip"), findsOneWidget);
    await tester.tap(find.text('< skip >'));

    verify(() => bloc.add(const SlipSkipped())).called(1);
  });

  testWidgets('shows what was read and what will be written', (tester) async {
    await pumpReview(tester, ready(draft()));

    expect(find.text('K PLUS · transfer'), findsOneWidget);
    expect(find.text('2026-09-29 09:15'), findsOneWidget);
    expect(find.text('none'), findsOneWidget);
    expect(find.text('will write'), findsOneWidget);
    expect(
      find.textContaining('Sample Property Co.', findRichText: true),
      findsNWidgets(2),
    );
    expect(find.text('Expenses:Uncategorized'), findsOneWidget);
    expect(find.text('Assets:Bank:KBank'), findsOneWidget);
  });

  testWidgets('save adds a save event for the draft', (tester) async {
    await pumpReview(tester, ready(draft()));

    await tester.tap(find.text('< save & next >'));

    verify(() => bloc.add(const SlipSaveRequested())).called(1);
  });

  testWidgets('a slip already in the ledger cannot be saved', (tester) async {
    await pumpReview(
      tester,
      ready(draft(duplicate: entry(description: 'Earlier'))),
    );

    expect(find.text('saved 09-29'), findsOneWidget);
    final save = tester.widget<TextButton>(
      find.ancestor(
        of: find.text('< save & next >'),
        matching: find.byType(TextButton),
      ),
    );
    expect(save.onPressed, isNull);
  });

  testWidgets('a slip with no amount has nothing to write', (tester) async {
    final parsed = transferSlip(satang: null);
    await pumpReview(
      tester,
      SlipReviewState(
        imagePaths: const ['a.jpg'],
        status: SlipReviewStatus.ready,
        draft: SlipDraft(
          imagePath: 'a.jpg',
          parsed: parsed,
          sourceAccount: 'Assets:Bank:KBank',
          categoryFromHistory: false,
          accounts: const [],
        ),
      ),
    );

    expect(find.text('--'), findsWidgets);
    final save = tester.widget<TextButton>(
      find.ancestor(
        of: find.text('< save & next >'),
        matching: find.byType(TextButton),
      ),
    );
    expect(save.onPressed, isNull);
  });

  testWidgets('both actions wait while a slip is being read', (tester) async {
    await pumpReview(
      tester,
      const SlipReviewState(imagePaths: ['a.jpg', 'b.jpg']),
    );

    final skip = tester.widget<TextButton>(
      find.ancestor(
        of: find.text('< skip >'),
        matching: find.byType(TextButton),
      ),
    );
    expect(skip.onPressed, isNull);
  });

  testWidgets('editing the payee sends the new description', (tester) async {
    await pumpReview(tester, ready(draft()));

    await tester.tap(
      find.textContaining('Sample Property Co.', findRichText: true).last,
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Landlord');
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    final sent = verify(() => bloc.add(captureAny())).captured;
    expect(
      sent.whereType<SlipDescriptionChanged>().single.description,
      'Landlord',
    );
  });

  testWidgets('cancelling the payee dialog sends nothing', (tester) async {
    await pumpReview(tester, ready(draft()));

    await tester.tap(
      find.textContaining('Sample Property Co.', findRichText: true).last,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    verifyNever(() => bloc.add(any(that: isA<SlipDescriptionChanged>())));
  });

  testWidgets('picking an account sends the posting and the account', (
    tester,
  ) async {
    await pumpReview(tester, ready(draft()));

    await tester.tap(find.text('Expenses:Uncategorized'));
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('Rent', findRichText: true));
    await tester.pumpAndSettle();

    final sent = verify(() => bloc.add(captureAny())).captured;
    final change = sent.whereType<SlipAccountChanged>().single;
    expect(change.posting, 0);
    expect(change.account, 'Expenses:Rent');
  });

  testWidgets('marks fields that need a look', (tester) async {
    await pumpReview(
      tester,
      ready(
        draft(
          parsed: transferSlip(confidence: const {SlipField.to: 0.3}),
          fromHistory: true,
        ),
      ),
    );

    expect(find.textContaining('!'), findsWidgets);
  });

  testWidgets('describes a broker order by its symbol', (tester) async {
    final parsed = ParsedSlip(
      Slip(
        source: SlipSource.dime,
        kind: SlipKind.buy,
        timestamp: DateTime.utc(2026, 9, 29, 2, 15),
        reference: 'ORD',
        amount: const slip_money.Money(300000),
        from: const SlipParty(name: 'Dime'),
      ),
    );
    await pumpReview(tester, ready(draft(parsed: parsed)));

    expect(find.text('Dime! · buy'), findsOneWidget);
  });

  testWidgets('a failed save shows a message and stays on the slip', (
    tester,
  ) async {
    final current = ready(draft());
    await pumpReview(
      tester,
      current,
      states: Stream.value(current.copyWith(error: SlipReviewError.saveFailed)),
    );
    await tester.pump();

    expect(find.text("Couldn't save the change"), findsOneWidget);
    expect(find.text('will write'), findsOneWidget);
  });

  testWidgets('finishing reports how many slips were saved and closes', (
    tester,
  ) async {
    final current = ready(draft());
    await pumpReview(
      tester,
      current,
      states: Stream.value(
        const SlipReviewState(
          imagePaths: ['a.jpg', 'b.jpg'],
          status: SlipReviewStatus.finished,
          savedCount: 2,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('2 slips saved'), findsOneWidget);
    expect(find.text('home'), findsOneWidget);
    expect(find.text('will write'), findsNothing);
  });

  testWidgets('finishing with nothing saved closes without a message', (
    tester,
  ) async {
    await pumpReview(
      tester,
      ready(draft()),
      states: Stream.value(
        const SlipReviewState(
          imagePaths: ['a.jpg'],
          status: SlipReviewStatus.finished,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(SnackBar), findsNothing);
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('the close button leaves the review', (tester) async {
    await pumpReview(tester, ready(draft()));

    await tester.tap(find.text('q'));
    await tester.pumpAndSettle();

    expect(find.text('will write'), findsNothing);
    expect(find.text('home'), findsOneWidget);
  });
}
