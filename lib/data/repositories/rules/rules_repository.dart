import 'package:ledger_app/domain/models/rule_set.dart';
import 'package:ledger_app/utils/result.dart';

abstract interface class RulesRepository {
  /// The rules saved earlier; Ok(null) before a file was ever imported.
  Future<Result<RuleSet?>> load();

  /// Asks the user for a rules file and reads it without saving. Ok(null)
  /// when they back out without choosing one.
  Future<Result<RuleSet?>> pickFile();

  Future<Result<void>> save(RuleSet rules);
}
