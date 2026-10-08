import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/services/ocr_line.dart';

void main() {
  const complete = <Object?, Object?>{
    'text': 'จำนวน',
    'confidence': 0.5,
    'x': 0.1,
    'y': 0.2,
    'width': 0.3,
    'height': 0.05,
  };

  test('reads every key of a channel entry', () {
    final line = OcrLine.fromMap(complete);

    expect(line.text, 'จำนวน');
    expect(line.confidence, 0.5);
    expect((line.x, line.y, line.width, line.height), (0.1, 0.2, 0.3, 0.05));
  });

  test('accepts whole numbers where the native side sends them', () {
    final line = OcrLine.fromMap({
      ...complete,
      'confidence': 1,
      'x': 0,
      'y': 1,
    });

    expect(line.confidence, 1.0);
    expect((line.x, line.y), (0.0, 1.0));
  });

  test('derives the far edges and the vertical center', () {
    final line = OcrLine.fromMap(complete);

    expect(line.right, closeTo(0.4, 1e-9));
    expect(line.bottom, closeTo(0.25, 1e-9));
    expect(line.centerY, closeTo(0.225, 1e-9));
  });

  test('rejects an entry with a missing or mistyped key', () {
    for (final key in complete.keys) {
      expect(
        () => OcrLine.fromMap({...complete}..remove(key)),
        throwsFormatException,
        reason: 'missing $key',
      );
    }
    expect(
      () => OcrLine.fromMap({...complete, 'text': 42}),
      throwsFormatException,
    );
    expect(
      () => OcrLine.fromMap({...complete, 'x': '0.1'}),
      throwsFormatException,
    );
  });

  test('prints its text and position for debugging', () {
    expect(OcrLine.fromMap(complete).toString(), 'OcrLine("จำนวน" @ 0.1,0.2)');
  });
}
