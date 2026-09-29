// Runs Apple Vision OCR on slip images and writes one JSON fixture per image,
// in the same shape the app's `ledger_app/slip_ocr` channel returns.
//
//   swift tool/ocr_dump.swift <out-dir> <image>...
//
// Keep the settings in sync with SlipOcrPlugin in ios/Runner/AppDelegate.swift.
import Foundation
import Vision

let args = CommandLine.arguments.dropFirst()
guard let outDir = args.first, args.count > 1 else {
  FileHandle.standardError.write("usage: ocr_dump.swift <out-dir> <image>...\n".data(using: .utf8)!)
  exit(2)
}
try FileManager.default.createDirectory(atPath: outDir, withIntermediateDirectories: true)

for path in args.dropFirst() {
  let url = URL(fileURLWithPath: path)
  let request = VNRecognizeTextRequest()
  request.recognitionLevel = .accurate
  request.recognitionLanguages = ["th-TH", "en-US"]
  request.usesLanguageCorrection = true
  try VNImageRequestHandler(url: url).perform([request])

  let lines: [[String: Any]] = (request.results ?? []).compactMap { observation in
    guard let best = observation.topCandidates(1).first else { return nil }
    let box = observation.boundingBox
    return [
      "text": best.string,
      "confidence": Double(best.confidence),
      "x": Double(box.minX),
      "y": Double(1 - box.maxY),
      "width": Double(box.width),
      "height": Double(box.height),
    ]
  }
  let fixture: [String: Any] = ["file": url.lastPathComponent, "lines": lines]
  let data = try JSONSerialization.data(
    withJSONObject: fixture, options: [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes])
  let out = URL(fileURLWithPath: outDir)
    .appendingPathComponent(url.deletingPathExtension().lastPathComponent + ".json")
  try data.write(to: out)
  print("wrote \(out.path) (\(lines.count) lines)")
}
