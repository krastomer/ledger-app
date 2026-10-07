import 'package:file_selector/file_selector.dart';
import 'package:ledger_app/utils/result.dart';

class LedgerFile {
  const LedgerFile({
    required this.name,
    required this.sizeBytes,
    required this.text,
  });

  final String name;
  final int sizeBytes;
  final String text;
}

class LedgerFileService {
  static const _jsonType = XTypeGroup(
    label: 'hledger JSON',
    extensions: ['json'],
    uniformTypeIdentifiers: ['public.json'],
    mimeTypes: ['application/json'],
  );

  Future<Result<LedgerFile?>> pick() async {
    try {
      final file = await openFile(acceptedTypeGroups: const [_jsonType]);
      if (file == null) return const Result.ok(null);
      final text = await file.readAsString();
      return Result.ok(
        LedgerFile(name: file.name, sizeBytes: await file.length(), text: text),
      );
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
