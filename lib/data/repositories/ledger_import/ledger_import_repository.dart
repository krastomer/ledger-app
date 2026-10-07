import 'package:ledger_app/domain/models/ledger_import_draft.dart';
import 'package:ledger_app/utils/result.dart';

abstract interface class LedgerImportRepository {
  /// Asks the user for an hledger export and reads it. Ok(null) when they
  /// back out without choosing a file.
  Future<Result<LedgerImportDraft?>> pickFile();
}
