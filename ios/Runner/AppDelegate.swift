import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var deeplinkChannel: FlutterEventChannel?
  private let swiftStreamHandler = SwiftStreamHandler()

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    deeplinkChannel = FlutterEventChannel(name: "flutter.native/merchantdeeplink", binaryMessenger: controller.binaryMessenger)
    deeplinkChannel?.setStreamHandler(swiftStreamHandler)

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        deeplinkChannel?.setStreamHandler(swiftStreamHandler)
        return swiftStreamHandler.handleLink(url.absoluteString)
    }
    
  final class SwiftStreamHandler: NSObject, FlutterStreamHandler {
      var eventSink: FlutterEventSink?
      var queuedLinks = [String]()
      
      func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
          self.eventSink = events
          queuedLinks.forEach({events($0)})
          queuedLinks.removeAll()
          return nil
      }
      func onCancel(withArguments arguments: Any?) -> FlutterError? {
          self.eventSink = nil
          return nil
      }
      
      func handleLink(_ link: String) -> Bool {
          guard let eventSink = eventSink else {
              queuedLinks.append(link)
              return false
          }
          eventSink(link)
          return true
      }
  }
}
