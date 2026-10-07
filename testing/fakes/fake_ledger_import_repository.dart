import 'package:ledger_app/data/repositories/ledger_import/ledger_import_repository.dart';
import 'package:ledger_app/domain/models/ledger_import_draft.dart';
import 'package:ledger_app/utils/result.dart';

class FakeLedgerImportRepository implements LedgerImportRepository {
  FakeLedgerImportRepository({this.draft, this.error});

  LedgerImportDraft? draft;
  Exception? error;

  @override
  Future<Result<LedgerImportDraft?>> pickFile() async => switch (error) {
    final error? => Result.error(error),
    null => Result.ok(draft),
  };
}
