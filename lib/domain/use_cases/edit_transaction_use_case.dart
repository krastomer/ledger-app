import 'package:ledger_app/data/repositories/ledger/ledger_repository.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';
import 'package:ledger_app/domain/models/transaction_status.dart';
import 'package:ledger_app/utils/result.dart';

class TransactionNotFoundException implements Exception {
  const TransactionNotFoundException(this.id);

  final String id;
}

/// Changes to one saved entry.
class EditTransactionUseCase {
  EditTransactionUseCase({required this._ledgerRepository});

  final LedgerRepository _ledgerRepository;

  Future<Result<void>> markCleared(String id) =>
      _update(id, (t) => t.copyWith(status: TransactionStatus.cleared));

  /// Moves every posting on [from] to [to].
  Future<Result<void>> recategorize(
    String id, {
    required String from,
    required String to,
  }) => _update(
    id,
    (t) => t.copyWith(
      postings: [
        for (final p in t.postings)
          p.account == from ? p.copyWith(account: to) : p,
      ],
    ),
  );

  Future<Result<void>> delete(String id) => _ledgerRepository.delete(id);

  Future<Result<void>> _update(
    String id,
    LedgerTransaction Function(LedgerTransaction) change,
  ) async {
    switch (await _ledgerRepository.getTransactions()) {
      case Ok(:final value):
        final transaction = value.where((t) => t.id == id).firstOrNull;
        if (transaction == null) {
          return Result.error(TransactionNotFoundException(id));
        }
        return _ledgerRepository.save(change(transaction));
      case Error(:final error):
        return Result.error(error);
    }
  }
}
