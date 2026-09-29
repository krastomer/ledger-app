import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/utils/result.dart';

abstract interface class SettingsRepository {
  Future<Result<AppSettings>> load();

  Future<Result<void>> save(AppSettings settings);
}
