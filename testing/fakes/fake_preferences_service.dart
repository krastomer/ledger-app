import 'package:ledger_app/data/services/preferences_service.dart';
import 'package:ledger_app/utils/result.dart';

class FakePreferencesService implements PreferencesService {
  FakePreferencesService({Map<String, String>? values, this.error})
    : values = values ?? {};

  final Map<String, String> values;
  final Exception? error;

  @override
  Future<Result<String?>> getString(String key) async => switch (error) {
    final error? => Result.error(error),
    null => Result.ok(values[key]),
  };

  @override
  Future<Result<void>> setString(String key, String value) async {
    if (error case final error?) return Result.error(error);
    values[key] = value;
    return const Result.ok(null);
  }
}
