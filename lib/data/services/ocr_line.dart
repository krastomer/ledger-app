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
  factory OcrLine.fromMap(Map<Object?, Object?> map) => OcrLine(
    text: map['text'] as String,
    confidence: (map['confidence'] as num).toDouble(),
    x: (map['x'] as num).toDouble(),
    y: (map['y'] as num).toDouble(),
    width: (map['width'] as num).toDouble(),
    height: (map['height'] as num).toDouble(),
  );

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
