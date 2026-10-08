import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/use_cases/import_slip_use_case.dart';
import 'package:ledger_app/ui/slip_review/bloc/slip_review_bloc.dart';

import 'package:ledger_app/utils/result.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fakes/fake_slip_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';
import '../../../../testing/fixtures/slip_draft_fixtures.dart';

class _RejectingWrites extends FakeLedgerRepository {
  _RejectingWrites({super.accounts, super.transactions});

  @override
  Future<Result<void>> save(LedgerTransaction transaction) async =>
      Result.error(Exception('read only'));
}

void main() {
  late FakeLedgerRepository ledger;

  setUp(() {
    ledger = FakeLedgerRepository(
      accounts: fixtureAccounts,
      transactions: fixtureTransactions,
    );
  });

  SlipReviewBloc build(List<String> paths) => SlipReviewBloc(
    imagePaths: paths,
    importSlip: ImportSlipUseCase(
      slipRepository: FakeSlipRepository({
        'new.jpg': transferSlip(),
        'old.jpg': transferSlip(reference: 'REF-1'),
      }),
      ledgerRepository: ledger,
      now: () => fixtureToday,
    ),
  );

  blocTest<SlipReviewBloc, SlipReviewState>(
    'reads the first slip',
    build: () => build(['new.jpg']),
    act: (bloc) => bloc.add(const SlipReviewStarted()),
    verify: (bloc) {
      expect(bloc.state.status, SlipReviewStatus.ready);
      expect(bloc.state.canSave, isTrue);
    },
  );

  blocTest<SlipReviewBloc, SlipReviewState>(
    'saving writes the edited entry and moves on',
    build: () => build(['new.jpg', 'missing.jpg']),
    act: (bloc) async {
      bloc.add(const SlipReviewStarted());
      await pumpEventQueue();
      bloc
        ..add(const SlipDescriptionChanged('Rent September'))
        ..add(const SlipAccountChanged(posting: 0, account: 'Expenses:Rent'))
        ..add(const SlipSaveRequested());
    },
    verify: (bloc) {
      final saved = ledger.transactions.last;
      expect(saved.description, 'Rent September');
      expect(saved.postings.first.account, 'Expenses:Rent');
      expect(bloc.state.savedCount, 1);
      expect(bloc.state.index, 1);
      expect(bloc.state.status, SlipReviewStatus.unreadable);
    },
  );

  blocTest<SlipReviewBloc, SlipReviewState>(
    'cannot save a slip that is already in the ledger',
    build: () => build(['old.jpg']),
    act: (bloc) async {
      bloc.add(const SlipReviewStarted());
      await pumpEventQueue();
      bloc.add(const SlipSaveRequested());
    },
    verify: (bloc) {
      expect(bloc.state.canSave, isFalse);
      expect(ledger.transactions, hasLength(fixtureTransactions.length));
    },
  );

  blocTest<SlipReviewBloc, SlipReviewState>(
    'finishes after skipping the last slip',
    build: () => build(['new.jpg']),
    act: (bloc) async {
      bloc.add(const SlipReviewStarted());
      await pumpEventQueue();
      bloc.add(const SlipSkipped());
    },
    verify: (bloc) {
      expect(bloc.state.status, SlipReviewStatus.finished);
      expect(bloc.state.savedCount, 0);
    },
  );

  blocTest<SlipReviewBloc, SlipReviewState>(
    'a failed save keeps the slip on screen and reports the error',
    build: () {
      ledger = _RejectingWrites(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      );
      return build(['new.jpg', 'missing.jpg']);
    },
    act: (bloc) async {
      bloc.add(const SlipReviewStarted());
      await pumpEventQueue();
      bloc.add(const SlipSaveRequested());
    },
    verify: (bloc) {
      expect(bloc.state.status, SlipReviewStatus.ready);
      expect(bloc.state.error, SlipReviewError.saveFailed);
      expect(bloc.state.savedCount, 0);
      expect(bloc.state.index, 0);
      expect(bloc.state.canSave, isTrue);
    },
  );

  blocTest<SlipReviewBloc, SlipReviewState>(
    'skipping reads the next slip',
    build: () => build(['new.jpg', 'old.jpg']),
    act: (bloc) async {
      bloc.add(const SlipReviewStarted());
      await pumpEventQueue();
      bloc.add(const SlipSkipped());
    },
    verify: (bloc) {
      expect(bloc.state.index, 1);
      expect(bloc.state.status, SlipReviewStatus.ready);
      expect(bloc.state.draft?.duplicate?.id, 'lunch');
    },
  );

  blocTest<SlipReviewBloc, SlipReviewState>(
    'ignores a blank description',
    build: () => build(['new.jpg']),
    act: (bloc) async {
      bloc.add(const SlipReviewStarted());
      await pumpEventQueue();
      bloc.add(const SlipDescriptionChanged('   '));
    },
    verify: (bloc) => expect(
      bloc.state.draft?.transaction?.description,
      'Sample Property Co., Ltd.',
    ),
  );

  blocTest<SlipReviewBloc, SlipReviewState>(
    'trims the description it is given',
    build: () => build(['new.jpg']),
    act: (bloc) async {
      bloc.add(const SlipReviewStarted());
      await pumpEventQueue();
      bloc.add(const SlipDescriptionChanged('  Landlord  '));
    },
    verify: (bloc) =>
        expect(bloc.state.draft?.transaction?.description, 'Landlord'),
  );

  blocTest<SlipReviewBloc, SlipReviewState>(
    'edits do nothing before a slip has been read',
    build: () => build(['new.jpg']),
    act: (bloc) => bloc
      ..add(const SlipDescriptionChanged('Landlord'))
      ..add(const SlipAccountChanged(posting: 0, account: 'Expenses:Rent')),
    expect: () => <SlipReviewState>[],
  );

  blocTest<SlipReviewBloc, SlipReviewState>(
    'a posting index outside the entry changes nothing',
    build: () => build(['new.jpg']),
    act: (bloc) async {
      bloc.add(const SlipReviewStarted());
      await pumpEventQueue();
      bloc.add(const SlipAccountChanged(posting: 9, account: 'Expenses:Rent'));
    },
    verify: (bloc) => expect(
      bloc.state.draft?.transaction?.postings.map((p) => p.account),
      [ImportSlipUseCase.uncategorized, 'Assets:Bank:KBank'],
    ),
  );

  blocTest<SlipReviewBloc, SlipReviewState>(
    'saving with nothing to save does nothing',
    build: () => build(['new.jpg']),
    act: (bloc) => bloc.add(const SlipSaveRequested()),
    expect: () => <SlipReviewState>[],
  );
}
