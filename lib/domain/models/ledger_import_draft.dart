import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';

part 'ledger_import_draft.freezed.dart';

@freezed
abstract class LedgerImportDraft with _$LedgerImportDraft {
  const LedgerImportDraft._();

  const factory LedgerImportDraft({
    required String fileName,
    required int sizeBytes,
    required List<Account> accounts,
    required List<LedgerTransaction> transactions,
  }) = _LedgerImportDraft;

  int get transactionCount => transactions.length;

  int get accountCount => {
    for (final t in transactions)
      for (final p in t.postings) p.account,
  }.length;

  int get unbalancedCount => transactions.where((t) => !t.isBalanced).length;

  DateTime? get firstDate => _dates.firstOrNull;

  DateTime? get lastDate => _dates.lastOrNull;

  List<DateTime> get _dates => [for (final t in transactions) t.date]..sort();
}
