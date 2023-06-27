import UIKit
import CoreLocation
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, CLLocationManagerDelegate, FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.events = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    
    let manager:CLLocationManager = CLLocationManager()
    var events: FlutterEventSink?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: "implementation.channel", binaryMessenger: controller.binaryMessenger)
        let eventChannel = FlutterEventChannel (name: "geolocation.listener", binaryMessenger: controller.binaryMessenger)
        eventChannel.setStreamHandler(self)
        manager.delegate = self
        methodChannel.setMethodCallHandler ({
            ( call: FlutterMethodCall,  result: FlutterResult)-> Void in
            
            switch call.method {
            case "version":
                let version =   UIDevice().systemVersion
                result("iOS \(version)")
                
            case "startLocation":
                self.startLocation()

            case "stopLocation":
                self.stoptLocation()
                
                
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
        
        
        
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func stoptLocation(){
        self.manager.stopUpdatingLocation()
    }
    
    private func startLocation(){
        self.manager.startUpdatingLocation()
    }
    
    override func applicationWillTerminate(_ application: UIApplication) {
        self.stoptLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location:[CLLocation]){
        if let location =  location.last {
            let coord :CLLocationCoordinate2D = location.coordinate
            print("iOS location \(coord.latitude), \(coord.longitude)")
            if self.events != nil {
                self.events!(["lat":coord.latitude, "lon":coord.longitude])
            }
        }
        
    }
}
