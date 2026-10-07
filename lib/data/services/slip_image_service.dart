import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ledger_app/utils/result.dart';

/// Lets the user pick slip images from the photo library.
class SlipImageService {
  SlipImageService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  /// Paths of local copies of the picked images; empty when cancelled.
  Future<Result<List<String>>> pickImages() async {
    try {
      final files = await _picker.pickMultiImage();
      return Result.ok([for (final file in files) file.path]);
    } on PlatformException catch (e) {
      return Result.error(Exception('Could not open photos (${e.code})'));
    }
  }
}
