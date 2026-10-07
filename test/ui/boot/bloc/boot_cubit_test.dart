import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/domain/use_cases/ledger_check_use_case.dart';
import 'package:ledger_app/ui/boot/bloc/boot_cubit.dart';

import '../../../../testing/fakes/fake_ledger_repository.dart';
import '../../../../testing/fixtures/ledger_fixtures.dart';

void main() {
  BootCubit build(FakeLedgerRepository repository) =>
      BootCubit(ledgerCheck: LedgerCheckUseCase(ledgerRepository: repository));

  blocTest<BootCubit, BootState>(
    'is ready with what the check found',
    build: () => build(
      FakeLedgerRepository(
        accounts: fixtureAccounts,
        transactions: fixtureTransactions,
      ),
    ),
    act: (cubit) => cubit.run(),
    expect: () => [
      isA<BootState>()
          .having((s) => s.status, 'status', BootStatus.ready)
          .having((s) => s.check?.reviewCount, 'reviewCount', 1),
    ],
  );

  blocTest<BootCubit, BootState>(
    'fails when the ledger cannot be opened',
    build: () => build(FakeLedgerRepository(error: Exception('disk'))),
    act: (cubit) => cubit.run(),
    expect: () => [const BootState(status: BootStatus.failed)],
  );
}
