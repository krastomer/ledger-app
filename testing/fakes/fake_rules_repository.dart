import 'package:ledger_app/data/repositories/rules/rules_repository.dart';
import 'package:ledger_app/domain/models/rule_set.dart';
import 'package:ledger_app/utils/result.dart';

class FakeRulesRepository implements RulesRepository {
  FakeRulesRepository({
    this.saved,
    this.picked,
    this.loadError,
    this.pickError,
    this.saveError,
  });

  RuleSet? saved;
  RuleSet? picked;
  Exception? loadError;
  Exception? pickError;
  Exception? saveError;

  @override
  Future<Result<RuleSet?>> load() async => switch (loadError) {
    final error? => Result.error(error),
    null => Result.ok(saved),
  };

  @override
  Future<Result<RuleSet?>> pickFile() async => switch (pickError) {
    final error? => Result.error(error),
    null => Result.ok(picked),
  };

  @override
  Future<Result<void>> save(RuleSet rules) async {
    if (saveError case final error?) return Result.error(error);
    saved = rules;
    return const Result.ok(null);
  }
}
