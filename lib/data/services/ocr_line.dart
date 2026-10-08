/// One line of text found by the native OCR.
///
/// The box is normalized to 0..1 of the image size with the origin at the
/// top-left, so layouts can be compared across screen sizes.
class OcrLine {
  const OcrLine({
    required this.text,
    this.confidence = 1,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  /// Reads one entry of the `recognize` result (see [SlipOcrService]).
  /// Throws a [FormatException] when a key is missing or of the wrong type.
  factory OcrLine.fromMap(Map<Object?, Object?> map) {
    if (map case {
      'text': final String text,
      'confidence': final num confidence,
      'x': final num x,
      'y': final num y,
      'width': final num width,
      'height': final num height,
    }) {
      return OcrLine(
        text: text,
        confidence: confidence.toDouble(),
        x: x.toDouble(),
        y: y.toDouble(),
        width: width.toDouble(),
        height: height.toDouble(),
      );
    }
    throw const FormatException('Unexpected OCR line');
  }

  final String text;

  /// 0..1; Vision reports only coarse values (0.3, 0.5, 1.0).
  final double confidence;

  final double x;
  final double y;
  final double width;
  final double height;

  double get right => x + width;
  double get bottom => y + height;
  double get centerY => y + height / 2;

  @override
  String toString() => 'OcrLine("$text" @ $x,$y)';
}
