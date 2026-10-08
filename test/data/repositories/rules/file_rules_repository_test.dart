import 'package:file_selector/file_selector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/repositories/rules/file_rules_repository.dart';
import 'package:ledger_app/data/services/ledger_file_service.dart';
import 'package:ledger_app/domain/models/rule_issue.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../../testing/fakes/fake_preferences_service.dart';

const _text = '''
if %payee BTS|MRT
  account2 expenses:transport
if %payee [bad
  account2 expenses:x
''';

class _FakeFiles implements LedgerFileService {
  _FakeFiles(this.result);

  Result<LedgerFile?> result;
  List<XTypeGroup>? asked;

  @override
  Future<Result<LedgerFile?>> pick({
    List<XTypeGroup> types = const [LedgerFileService.jsonType],
  }) async {
    asked = types;
    return result;
  }
}

void main() {
  final now = DateTime(2026, 10, 8, 9, 12);
  late FakePreferencesService preferences;
  late _FakeFiles files;

  setUp(() {
    preferences = FakePreferencesService();
    files = _FakeFiles(
      const Result.ok(
        LedgerFile(name: 'ledger.rules', sizeBytes: 90, text: _text),
      ),
    );
  });

  FileRulesRepository repository() => FileRulesRepository(
    files: files,
    preferences: preferences,
    now: () => now,
  );

  test('asks for a rules file, not a JSON export', () async {
    await repository().pickFile();

    expect(files.asked, [LedgerFileService.rulesType]);
  });

  test('reads the chosen file into rules and skipped lines', () async {
    final result = await repository().pickFile();

    final rules = (result as Ok).value;
    expect(rules.fileName, 'ledger.rules');
    expect(rules.loadedAt, now);
    expect(rules.rules.single.account, 'expenses:transport');
    expect(rules.issues.single.reason, RuleIssueReason.badRegex);
  });

  test('is ok with nothing when the user backs out', () async {
    files.result = const Result.ok(null);

    final result = await repository().pickFile();

    expect((result as Ok).value, isNull);
  });

  test('passes on a file that cannot be opened', () async {
    files.result = Result.error(Exception('no access'));

    expect(await repository().pickFile(), isA<Error<Object?>>());
  });

  test('has nothing before a file was saved', () async {
    final result = await repository().load();

    expect((result as Ok).value, isNull);
  });

  test('loads what it saved, parsed again', () async {
    final picked = ((await repository().pickFile()) as Ok).value;
    await repository().save(picked);

    final loaded = ((await repository().load()) as Ok).value;

    expect(loaded, picked);
  });

  test('fails to save when the preferences are unavailable', () async {
    preferences = FakePreferencesService(error: Exception('disk'));
    final picked = ((await repository().pickFile()) as Ok).value;

    expect(await repository().save(picked), isA<Error<void>>());
  });

  test('fails to load when the preferences are unavailable', () async {
    preferences = FakePreferencesService(error: Exception('disk'));

    expect(await repository().load(), isA<Error<Object?>>());
  });
}
