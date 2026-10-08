import 'package:flutter_test/flutter_test.dart';
import 'package:ledger_app/data/parsers/slip/parsed_slip.dart';
import 'package:ledger_app/data/repositories/slip/ocr_slip_repository.dart';
import 'package:ledger_app/data/services/ocr_line.dart';
import 'package:ledger_app/data/services/slip_image_service.dart';
import 'package:ledger_app/data/services/slip_ocr_service.dart';
import 'package:ledger_app/domain/models/slip.dart';
import 'package:ledger_app/utils/result.dart';

import '../../../../testing/fixtures/slip_fixtures.dart';

class _FakeOcr extends Fake implements SlipOcrService {
  _FakeOcr(this.result);

  final Result<List<OcrLine>> result;
  String? lastPath;

  @override
  Future<Result<List<OcrLine>>> recognize(String imagePath) async {
    lastPath = imagePath;
    return result;
  }
}

class _FakeImages extends Fake implements SlipImageService {
  @override
  Future<Result<List<String>>> pickImages() async => const Result.ok(['a.jpg']);
}

void main() {
  OcrSlipRepository repositoryFor(Result<List<OcrLine>> ocr) =>
      OcrSlipRepository(ocr: _FakeOcr(ocr), images: _FakeImages());

  test('passes the image picker through', () async {
    final result = await repositoryFor(const Result.ok([])).pickImages();

    expect((result as Ok<List<String>>).value, ['a.jpg']);
  });

  test('parses the OCR lines of a known slip layout', () async {
    final fixture = SlipFixture.load('slips/kplus_transfer.json');
    final ocr = _FakeOcr(Result.ok(fixture.lines));

    final result = await OcrSlipRepository(
      ocr: ocr,
      images: _FakeImages(),
    ).read('/tmp/slip.jpg');

    final parsed = (result as Ok<ParsedSlip>).value;
    expect(ocr.lastPath, '/tmp/slip.jpg');
    expect(parsed.slip.source, SlipSource.kbank);
    expect(parsed.slip.kind, SlipKind.transfer);
  });

  test('fails as unknown when no layout matches the text', () async {
    final result = await repositoryFor(
      const Result.ok([
        OcrLine(text: 'hello', x: 0, y: 0, width: 1, height: 0.1),
      ]),
    ).read('photo.jpg');

    expect((result as Error<ParsedSlip>).error, isA<UnknownSlipException>());
  });

  test('passes an OCR failure on unchanged', () async {
    final failure = Exception('ocr down');

    final result = await repositoryFor(Result.error(failure)).read('x.jpg');

    expect((result as Error<ParsedSlip>).error, same(failure));
  });
}
