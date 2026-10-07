import 'package:flutter/material.dart';
import 'package:ledger_app/app.dart';
import 'package:ledger_app/data/repositories/ledger/hledger_ledger_repository.dart';
import 'package:ledger_app/data/repositories/settings/preferences_settings_repository.dart';
import 'package:ledger_app/data/repositories/slip/ocr_slip_repository.dart';
import 'package:ledger_app/data/services/ledger_asset_service.dart';
import 'package:ledger_app/data/services/preferences_service.dart';
import 'package:ledger_app/data/services/slip_image_service.dart';
import 'package:ledger_app/data/services/slip_ocr_service.dart';
import 'package:ledger_app/domain/models/app_settings.dart';
import 'package:ledger_app/routing/router.dart';
import 'package:ledger_app/utils/result.dart';

/// `--dart-define=LEDGER_ASSET=assets/ledger/local.json` runs on a real
/// export from tool/export_ledger.sh.
const _ledgerAsset = String.fromEnvironment(
  'LEDGER_ASSET',
  defaultValue: 'assets/ledger/sample.json',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsRepository = PreferencesSettingsRepository(
    preferences: PreferencesService(),
  );
  final settings = switch (await settingsRepository.load()) {
    Ok(:final value) => value,
    Error() => const AppSettings(),
  };
  runApp(
    App(
      // TODO(kasama): replace with the SQLite repository (sync.md).
      ledgerRepository: HledgerLedgerRepository(
        source: LedgerAssetService(path: _ledgerAsset),
      ),
      settingsRepository: settingsRepository,
      slipRepository: OcrSlipRepository(
        ocr: SlipOcrService(),
        images: SlipImageService(),
      ),
      initialSettings: settings,
      router: createRouter(),
    ),
  );
}
