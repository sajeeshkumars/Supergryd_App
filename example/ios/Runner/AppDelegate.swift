   
    import UIKit
    import Flutter
    import GoogleMaps
     
    @UIApplicationMain
    @objc class AppDelegate: FlutterAppDelegate {
      override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
      ) -> Bool {
          GMSServices.provideAPIKey("AIzaSyBkEMGux54F5lqQ7_bXIjWVf5m3jaRdYdk")
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      }
    }
     
