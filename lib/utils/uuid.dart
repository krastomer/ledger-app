import 'dart:math';

final _random = Random.secure();

/// A time-ordered UUID (version 7): IDs made on the device sort by when
/// they were created and never need a server (sync.md).
String uuidV7({DateTime? now}) {
  final millis = (now ?? DateTime.now()).millisecondsSinceEpoch;
  final bytes = [for (var i = 0; i < 16; i++) _random.nextInt(256)];
  for (var i = 0; i < 6; i++) {
    bytes[i] = (millis >> (8 * (5 - i))) & 0xff;
  }
  bytes[6] = 0x70 | (bytes[6] & 0x0f);
  bytes[8] = 0x80 | (bytes[8] & 0x3f);
  final hex = [for (final byte in bytes) byte.toRadixString(16).padLeft(2, '0')]
      .join();
  return [
    hex.substring(0, 8),
    hex.substring(8, 12),
    hex.substring(12, 16),
    hex.substring(16, 20),
    hex.substring(20),
  ].join('-');
}
