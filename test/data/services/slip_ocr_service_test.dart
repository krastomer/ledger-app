import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/services/ocr_line.dart';
import 'package:ledger_app/data/services/slip_ocr_service.dart';
import 'package:ledger_app/utils/result.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('ledger_app/slip_ocr');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final service = SlipOcrService();

  void answerWith(Future<Object?> Function(MethodCall call) handler) =>
      messenger.setMockMethodCallHandler(channel, handler);

  tearDown(() => messenger.setMockMethodCallHandler(channel, null));

  Map<String, Object?> entry(String text) => {
    'text': text,
    'confidence': 1.0,
    'x': 0.0,
    'y': 0.0,
    'width': 1.0,
    'height': 0.1,
  };

  Exception errorOf(Result<List<OcrLine>> result) =>
      (result as Error<List<OcrLine>>).error;

  test('sends the image path and returns the lines in order', () async {
    MethodCall? received;
    answerWith((call) async {
      received = call;
      return [entry('first'), entry('second')];
    });

    final result = await service.recognize('/tmp/slip.jpg');

    expect(received?.method, 'recognize');
    expect(received?.arguments, '/tmp/slip.jpg');
    expect((result as Ok<List<OcrLine>>).value.map((line) => line.text), [
      'first',
      'second',
    ]);
  });

  test('treats a null answer as no lines', () async {
    answerWith((_) async => null);

    final result = await service.recognize('slip.jpg');

    expect((result as Ok<List<OcrLine>>).value, isEmpty);
  });

  test('fails gracefully where the platform has no OCR', () async {
    final result = await service.recognize('slip.jpg');

    expect(errorOf(result).toString(), contains('not available'));
  });

  test('reports the native error code without the message', () async {
    answerWith(
      (_) async =>
          throw PlatformException(code: 'ocr_failed', message: 'private text'),
    );

    final message = errorOf(await service.recognize('slip.jpg')).toString();

    expect(message, contains('ocr_failed'));
    expect(message, isNot(contains('private text')));
  });

  test('fails instead of throwing on a malformed answer', () async {
    for (final answer in <Object?>[
      [entry('ok'), 'not a map'],
      [
        {'text': 'no geometry'},
      ],
    ]) {
      answerWith((_) async => answer);

      final result = await service.recognize('slip.jpg');

      expect(errorOf(result).toString(), contains('unexpected data'));
    }
  });
}
