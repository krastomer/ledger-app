import 'package:ledger_app/data/repositories/settings/settings_repository.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/utils/result.dart';

class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository({this.saved = const AppSettings(), this.error});

  AppSettings saved;
  final Exception? error;

  @override
  Future<Result<AppSettings>> load() async => switch (error) {
    final error? => Result.error(error),
    null => Result.ok(saved),
  };

  @override
  Future<Result<void>> save(AppSettings settings) async {
    if (error case final error?) return Result.error(error);
    saved = settings;
    return const Result.ok(null);
  }
}
