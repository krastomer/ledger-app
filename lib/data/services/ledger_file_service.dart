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
  LedgerFileService({Future<XFile?> Function(List<XTypeGroup>)? opener})
    : _opener = opener ?? _openFile;

  static const jsonType = XTypeGroup(
    label: 'hledger JSON',
    extensions: ['json'],
    uniformTypeIdentifiers: ['public.json'],
    mimeTypes: ['application/json'],
  );

  static const rulesType = XTypeGroup(
    label: 'ledger rules',
    extensions: ['rules', 'txt'],
    // Android knows only txt; without */* its picker greys out .rules files.
    mimeTypes: ['*/*'],
    uniformTypeIdentifiers: ['public.data'],
  );

  final Future<XFile?> Function(List<XTypeGroup>) _opener;

  static Future<XFile?> _openFile(List<XTypeGroup> types) =>
      openFile(acceptedTypeGroups: types);

  Future<Result<LedgerFile?>> pick({
    List<XTypeGroup> types = const [jsonType],
  }) async {
    try {
      final file = await _opener(types);
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
