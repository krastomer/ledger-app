import Flutter
import UIKit
import Vision

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    if let registrar = engineBridge.pluginRegistry.registrar(forPlugin: "SlipOcrPlugin") {
      SlipOcrPlugin.register(with: registrar)
    }
  }
}

/// On-device OCR for slip images using Apple's Vision framework.
///
/// `recognize(path)` returns one map per text line:
/// `{text, confidence, x, y, width, height}`, with the box normalized to
/// 0...1 and the origin at the top-left of the image.
class SlipOcrPlugin: NSObject, FlutterPlugin {
  static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "ledger_app/slip_ocr", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(SlipOcrPlugin(), channel: channel)
  }

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard call.method == "recognize" else {
      result(FlutterMethodNotImplemented)
      return
    }
    guard let path = call.arguments as? String else {
      result(FlutterError(code: "bad_args", message: "expected an image path", details: nil))
      return
    }

    DispatchQueue.global(qos: .userInitiated).async {
      let request = VNRecognizeTextRequest()
      request.recognitionLevel = .accurate
      request.recognitionLanguages = ["th-TH", "en-US"]
      request.usesLanguageCorrection = true

      do {
        try VNImageRequestHandler(url: URL(fileURLWithPath: path)).perform([request])
        let lines: [[String: Any]] = (request.results ?? []).compactMap { observation in
          guard let best = observation.topCandidates(1).first else { return nil }
          let box = observation.boundingBox  // Vision's origin is bottom-left.
          return [
            "text": best.string,
            "confidence": Double(best.confidence),
            "x": Double(box.minX),
            "y": Double(1 - box.maxY),
            "width": Double(box.width),
            "height": Double(box.height),
          ]
        }
        DispatchQueue.main.async { result(lines) }
      } catch {
        DispatchQueue.main.async {
          result(FlutterError(code: "ocr_failed", message: error.localizedDescription, details: nil))
        }
      }
    }
  }
}
