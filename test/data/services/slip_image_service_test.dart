import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ledger_app/data/services/slip_image_service.dart';
import 'package:ledger_app/utils/result.dart';

class _FakePicker extends Fake implements ImagePicker {
  _FakePicker({this.files = const [], this.error});

  final List<XFile> files;
  final Object? error;

  @override
  Future<List<XFile>> pickMultiImage({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    int? limit,
    bool requestFullMetadata = true,
  }) async {
    if (error case final error?) throw error;
    return files;
  }
}

void main() {
  test('returns the local paths of the picked images', () async {
    final service = SlipImageService(
      picker: _FakePicker(files: [XFile('/tmp/a.jpg'), XFile('/tmp/b.jpg')]),
    );

    final result = await service.pickImages();

    expect((result as Ok<List<String>>).value, ['/tmp/a.jpg', '/tmp/b.jpg']);
  });

  test('returns nothing when the user cancels', () async {
    final result = await SlipImageService(picker: _FakePicker()).pickImages();

    expect((result as Ok<List<String>>).value, isEmpty);
  });

  test('turns a platform failure into an error with its code', () async {
    final service = SlipImageService(
      picker: _FakePicker(
        error: PlatformException(code: 'photo_access_denied'),
      ),
    );

    final result = await service.pickImages();

    expect(
      (result as Error<List<String>>).error.toString(),
      contains('photo_access_denied'),
    );
  });
}
