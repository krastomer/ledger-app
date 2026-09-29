import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ledger_app/domain/models/account.dart';
import 'package:ledger_app/domain/models/ledger_transaction.dart';

part 'parsed_ledger.freezed.dart';

@freezed
abstract class ParsedLedger with _$ParsedLedger {
  const factory ParsedLedger({
    required List<Account> accounts,
    required List<LedgerTransaction> transactions,
    required List<LedgerIssue> issues,
  }) = _ParsedLedger;
}

@freezed
abstract class LedgerIssue with _$LedgerIssue {
  const factory LedgerIssue({
    /// Position in the exported array; null when the whole export is bad.
    int? entry,
    required LedgerIssueKind kind,
  }) = _LedgerIssue;
}

enum LedgerIssueKind {
  malformed,
  unknownAccountType,
  unsupportedCommodity,
  unsupportedCost,
  unsupportedVirtualPosting,
  badAmount,
}
