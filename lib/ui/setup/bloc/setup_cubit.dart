import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/data/repositories/ledger/hledger_ledger_repository.dart';
import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/data/repositories/ledger_import/ledger_import_repository.dart';
import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/ledger_import_draft.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/starter_accounts.dart';
import 'package:ledger_app/utils/result.dart';

part 'setup_cubit.freezed.dart';
part 'setup_state.dart';

class SetupCubit extends Cubit<SetupState> {
  SetupCubit({required this._importRepository, required this._ledgerRepository})
    : super(const SetupState());

  final LedgerImportRepository _importRepository;
  final LedgerRepository _ledgerRepository;

  Future<void> pickFile() async {
    emit(state.copyWith(status: SetupStatus.picking, error: null));
    final result = await _importRepository.pickFile();
    if (isClosed) return;
    emit(switch (result) {
      Ok(value: final draft?) => SetupState(
        status: SetupStatus.ready,
        draft: draft,
      ),
      Ok() => state.copyWith(status: _resting(state.draft)),
      Error(error: LedgerImportException(:final issues)) => SetupState(
        unreadableCount: issues.length,
        error: SetupError.unreadableFile,
      ),
      Error() => SetupState(error: SetupError.fileFailed),
    });
  }

  Future<void> startNew() => _replace(accounts: starterAccounts);

  Future<void> importDraft() async {
    final draft = state.draft;
    if (draft == null) return;
    await _replace(accounts: draft.accounts, transactions: draft.transactions);
  }

  Future<void> _replace({
    required List<Account> accounts,
    List<LedgerTransaction> transactions = const [],
  }) async {
    emit(state.copyWith(status: SetupStatus.saving, error: null));
    final result = await _ledgerRepository.replaceAll(
      accounts: accounts,
      transactions: transactions,
    );
    if (isClosed) return;
    emit(
      result is Error<void>
          ? state.copyWith(
              status: _resting(state.draft),
              error: SetupError.saveFailed,
            )
          : state.copyWith(status: SetupStatus.done),
    );
  }

  static SetupStatus _resting(LedgerImportDraft? draft) =>
      draft == null ? SetupStatus.idle : SetupStatus.ready;
}
