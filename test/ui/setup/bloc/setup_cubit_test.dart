import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/parsers/hledger/parsed_ledger.dart';
import 'package:ledger_app/data/repositories/ledger/hledger_ledger_repository.dart';
import 'package:ledger_app/domain/models/ledger_import_draft.dart';
import 'package:ledger_app/domain/models/starter_accounts.dart';
import 'package:ledger_app/ui/setup/bloc/setup_cubit.dart';

import '../../../../testing/fakes/fake_ledger_import_repository.dart';
import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  final draft = LedgerImportDraft(
    fileName: 'ledger.json',
    sizeBytes: 2048,
    accounts: fixtureAccounts,
    transactions: fixtureTransactions,
  );

  SetupCubit build({
    FakeLedgerImportRepository? imports,
    FakeLedgerRepository? ledger,
  }) => SetupCubit(
    importRepository: imports ?? FakeLedgerImportRepository(draft: draft),
    ledgerRepository: ledger ?? FakeLedgerRepository(),
  );

  group('pickFile', () {
    blocTest<SetupCubit, SetupState>(
      'is ready with the file that was read',
      build: build,
      act: (cubit) => cubit.pickFile(),
      expect: () => [
        const SetupState(status: SetupStatus.picking),
        SetupState(status: SetupStatus.ready, draft: draft),
      ],
    );

    blocTest<SetupCubit, SetupState>(
      'goes back to idle when the user backs out',
      build: () => build(imports: FakeLedgerImportRepository()),
      act: (cubit) => cubit.pickFile(),
      expect: () => [
        const SetupState(status: SetupStatus.picking),
        const SetupState(),
      ],
    );

    blocTest<SetupCubit, SetupState>(
      'keeps the earlier file when the user backs out of choosing another',
      build: () => build(imports: FakeLedgerImportRepository()),
      seed: () => SetupState(status: SetupStatus.ready, draft: draft),
      act: (cubit) => cubit.pickFile(),
      expect: () => [
        SetupState(status: SetupStatus.picking, draft: draft),
        SetupState(status: SetupStatus.ready, draft: draft),
      ],
    );

    blocTest<SetupCubit, SetupState>(
      'reports how many entries could not be read',
      build: () => build(
        imports: FakeLedgerImportRepository(
          error: const LedgerImportException([
            LedgerIssue(kind: LedgerIssueKind.badAmount),
            LedgerIssue(entry: 3, kind: LedgerIssueKind.malformed),
          ]),
        ),
      ),
      act: (cubit) => cubit.pickFile(),
      expect: () => [
        const SetupState(status: SetupStatus.picking),
        const SetupState(error: SetupError.unreadableFile, unreadableCount: 2),
      ],
    );

    blocTest<SetupCubit, SetupState>(
      'fails when the file cannot be opened',
      build: () =>
          build(imports: FakeLedgerImportRepository(error: Exception('io'))),
      act: (cubit) => cubit.pickFile(),
      expect: () => [
        const SetupState(status: SetupStatus.picking),
        const SetupState(error: SetupError.fileFailed),
      ],
    );
  });

  group('startNew', () {
    test('replaces the ledger with the starter accounts only', () async {
      final ledger = FakeLedgerRepository(transactions: fixtureTransactions);
      final cubit = build(ledger: ledger);
      addTearDown(cubit.close);

      await cubit.startNew();

      expect(ledger.accounts, starterAccounts);
      expect(ledger.transactions, isEmpty);
      expect(cubit.state.status, SetupStatus.done);
    });

    blocTest<SetupCubit, SetupState>(
      'reports a failed save and can be tried again',
      build: () => build(ledger: FakeLedgerRepository(error: Exception('x'))),
      act: (cubit) => cubit.startNew(),
      expect: () => [
        const SetupState(status: SetupStatus.saving),
        const SetupState(error: SetupError.saveFailed),
      ],
    );
  });

  group('importDraft', () {
    test('replaces the ledger with what the file held', () async {
      final ledger = FakeLedgerRepository();
      final cubit = build(ledger: ledger);
      addTearDown(cubit.close);
      await cubit.pickFile();

      await cubit.importDraft();

      expect(ledger.accounts, draft.accounts);
      expect(ledger.transactions, draft.transactions);
      expect(cubit.state.status, SetupStatus.done);
    });

    blocTest<SetupCubit, SetupState>(
      'does nothing before a file is chosen',
      build: build,
      act: (cubit) => cubit.importDraft(),
      expect: () => <SetupState>[],
    );

    blocTest<SetupCubit, SetupState>(
      'keeps the file when saving fails',
      build: () => build(ledger: FakeLedgerRepository(error: Exception('x'))),
      seed: () => SetupState(status: SetupStatus.ready, draft: draft),
      act: (cubit) => cubit.importDraft(),
      expect: () => [
        SetupState(status: SetupStatus.saving, draft: draft),
        SetupState(
          status: SetupStatus.ready,
          draft: draft,
          error: SetupError.saveFailed,
        ),
      ],
    );
  });
}
