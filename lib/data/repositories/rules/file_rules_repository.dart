import 'package:ledger_app/data/parsers/rules/rules_parser.dart';
import 'package:ledger_app/data/services/ledger_file_service.dart';
import 'package:ledger_app/data/services/preferences_service.dart';
import 'package:ledger_app/domain/models/rule_set.dart';
import 'package:ledger_app/utils/result.dart';

import 'rules_repository.dart';

class FileRulesRepository implements RulesRepository {
  FileRulesRepository({
    required this._files,
    required this._preferences,
    this._parser = const RulesParser(),
    this._now = DateTime.now,
  });

  static const _fileNameKey = 'rules.fileName';
  static const _textKey = 'rules.text';
  static const _loadedAtKey = 'rules.loadedAt';

  final LedgerFileService _files;
  final PreferencesService _preferences;
  final RulesParser _parser;
  final DateTime Function() _now;

  @override
  Future<Result<RuleSet?>> load() async {
    final (name, text, loadedAt) = await (
      _preferences.getString(_fileNameKey),
      _preferences.getString(_textKey),
      _preferences.getString(_loadedAtKey),
    ).wait;
    for (final result in [name, text, loadedAt]) {
      if (result case Error(:final error)) return Result.error(error);
    }
    final savedText = switch (text) {
      Ok(:final value) => value,
      Error() => null,
    };
    if (savedText == null) return const Result.ok(null);
    final savedName = switch (name) {
      Ok(:final value) => value,
      Error() => null,
    };
    final savedAt = switch (loadedAt) {
      Ok(:final value?) => DateTime.tryParse(value),
      _ => null,
    };
    return Result.ok(_build(savedName ?? '', savedText, savedAt ?? _now()));
  }

  @override
  Future<Result<RuleSet?>> pickFile() async {
    switch (await _files.pick(types: const [LedgerFileService.rulesType])) {
      case Ok(value: null):
        return const Result.ok(null);
      case Ok(:final value?):
        return Result.ok(_build(value.name, value.text, _now()));
      case Error(:final error):
        return Result.error(error);
    }
  }

  @override
  Future<Result<void>> save(RuleSet rules) async {
    final results = await Future.wait([
      _preferences.setString(_fileNameKey, rules.fileName),
      _preferences.setString(_textKey, rules.text),
      _preferences.setString(_loadedAtKey, rules.loadedAt.toIso8601String()),
    ]);
    for (final result in results) {
      if (result case Error(:final error)) return Result.error(error);
    }
    return const Result.ok(null);
  }

  RuleSet _build(String name, String text, DateTime loadedAt) {
    final parsed = _parser.parse(text);
    return RuleSet(
      fileName: name,
      text: text,
      loadedAt: loadedAt,
      rules: parsed.rules,
      issues: parsed.issues,
    );
  }
}
