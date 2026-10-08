import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/utils/file_size_format.dart';

void main() {
  test('shows small files in bytes', () {
    expect(formatFileSize(0), '0 B');
    expect(formatFileSize(1023), '1023 B');
  });

  test('rounds larger files up to whole kilobytes', () {
    expect(formatFileSize(1024), '1 KB');
    expect(formatFileSize(1025), '2 KB');
    expect(formatFileSize(84 * 1024), '84 KB');
  });
}
