import 'package:ledger_app/data/parsers/hledger/hledger_json_parser.dart';
import 'package:ledger_app/data/repositories/ledger/hledger_ledger_repository.dart';
import 'package:ledger_app/data/services/ledger_file_service.dart';
import 'package:ledger_app/domain/models/ledger_import_draft.dart';
import 'package:ledger_app/utils/result.dart';

import 'ledger_import_repository.dart';

class FileLedgerImportRepository implements LedgerImportRepository {
  FileLedgerImportRepository({
    required this._files,
    this._parser = const HledgerJsonParser(),
  });

  final LedgerFileService _files;
  final HledgerJsonParser _parser;

  @override
  Future<Result<LedgerImportDraft?>> pickFile() async {
    switch (await _files.pick()) {
      case Ok(value: null):
        return const Result.ok(null);
      case Ok(:final value?):
        final ledger = _parser.parse(value.text);
        if (ledger.issues.isNotEmpty) {
          return Result.error(LedgerImportException(ledger.issues));
        }
        return Result.ok(
          LedgerImportDraft(
            fileName: value.name,
            sizeBytes: value.sizeBytes,
            accounts: ledger.accounts,
            transactions: ledger.transactions,
          ),
        );
      case Error(:final error):
        return Result.error(error);
    }
  }
}
