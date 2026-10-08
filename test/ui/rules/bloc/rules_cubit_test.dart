import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/ui/rules/bloc/rules_cubit.dart';

import '../../../../testing/fakes/fake_rules_repository.dart';
import '../../../../testing/fixtures/rules_fixtures.dart';

void main() {
  final saved = ruleSet(fileName: 'old.rules');
  final picked = ruleSet(fileName: 'new.rules');

  blocTest<RulesCubit, RulesState>(
    'loads the saved rules',
    build: () => RulesCubit(repository: FakeRulesRepository(saved: saved)),
    act: (cubit) => cubit.load(),
    expect: () => [
      RulesState(status: RulesStatus.loading),
      RulesState(status: RulesStatus.idle, saved: saved),
    ],
  );

  blocTest<RulesCubit, RulesState>(
    'says so when the saved rules cannot be read',
    build: () =>
        RulesCubit(repository: FakeRulesRepository(loadError: Exception('x'))),
    act: (cubit) => cubit.load(),
    expect: () => [
      RulesState(status: RulesStatus.loading),
      RulesState(status: RulesStatus.idle, error: RulesError.loadFailed),
    ],
  );

  blocTest<RulesCubit, RulesState>(
    'keeps a picked file as a draft without saving it',
    build: () => RulesCubit(repository: FakeRulesRepository(picked: picked)),
    act: (cubit) => cubit.pickFile(),
    expect: () => [
      RulesState(status: RulesStatus.picking),
      RulesState(status: RulesStatus.idle, draft: picked),
    ],
  );

  blocTest<RulesCubit, RulesState>(
    'changes nothing when the user backs out',
    build: () => RulesCubit(repository: FakeRulesRepository()),
    act: (cubit) => cubit.pickFile(),
    expect: () => [
      RulesState(status: RulesStatus.picking),
      RulesState(status: RulesStatus.idle),
    ],
  );

  blocTest<RulesCubit, RulesState>(
    'reports a file that cannot be opened',
    build: () =>
        RulesCubit(repository: FakeRulesRepository(pickError: Exception('x'))),
    act: (cubit) => cubit.pickFile(),
    expect: () => [
      RulesState(status: RulesStatus.picking),
      RulesState(status: RulesStatus.idle, error: RulesError.fileFailed),
    ],
  );

  final empty = ruleSet(rules: const []);
  blocTest<RulesCubit, RulesState>(
    'reports a file without any rule and refuses to save it',
    build: () => RulesCubit(repository: FakeRulesRepository(picked: empty)),
    act: (cubit) async {
      await cubit.pickFile();
      await cubit.commit();
    },
    expect: () => [
      RulesState(status: RulesStatus.picking),
      RulesState(
        status: RulesStatus.idle,
        draft: empty,
        error: RulesError.noRules,
      ),
    ],
  );

  blocTest<RulesCubit, RulesState>(
    'commit saves the draft and makes it the current rules',
    build: () => RulesCubit(repository: FakeRulesRepository(picked: picked)),
    act: (cubit) async {
      await cubit.pickFile();
      await cubit.commit();
    },
    skip: 2,
    expect: () => [
      RulesState(status: RulesStatus.saving, draft: picked),
      RulesState(status: RulesStatus.done, saved: picked),
    ],
  );

  blocTest<RulesCubit, RulesState>(
    'commit keeps the draft when saving fails',
    build: () => RulesCubit(
      repository: FakeRulesRepository(
        picked: picked,
        saveError: Exception('x'),
      ),
    ),
    act: (cubit) async {
      await cubit.pickFile();
      await cubit.commit();
    },
    skip: 2,
    expect: () => [
      RulesState(status: RulesStatus.saving, draft: picked),
      RulesState(
        status: RulesStatus.idle,
        draft: picked,
        error: RulesError.saveFailed,
      ),
    ],
  );

  test('replace picks a file and saves it in one go', () async {
    final repository = FakeRulesRepository(saved: saved, picked: picked);
    final cubit = RulesCubit(repository: repository);
    addTearDown(cubit.close);
    await cubit.load();

    await cubit.replace();

    expect(repository.saved, picked);
    expect(cubit.state.saved, picked);
    expect(cubit.state.status, RulesStatus.done);
  });

  test(
    'replace leaves the saved rules alone when nothing was chosen',
    () async {
      final repository = FakeRulesRepository(saved: saved);
      final cubit = RulesCubit(repository: repository);
      addTearDown(cubit.close);
      await cubit.load();

      await cubit.replace();

      expect(repository.saved, saved);
      expect(cubit.state.saved, saved);
    },
  );
}
