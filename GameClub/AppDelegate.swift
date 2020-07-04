




import UIKit
import FBSDKCoreKit
import Google
import GoogleSignIn
import TwitterKit
import CoreData
import Alamofire
import MOLH

var isNetworkReachable = NetworkReachabilityManager()?.isReachable ?? false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MOLHResetable {
    func reset() {
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
                    let stry = UIStoryboard(name: "Main", bundle: nil)
                    rootviewcontroller.rootViewController = stry.instantiateViewController(withIdentifier: "rootnav")
    }
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance().clientID = "291668164025-gbo6je7gcijnflp3hktm1hlulol0cohb.apps.googleusercontent.com"
        TWTRTwitter.sharedInstance().start(withConsumerKey:"sfGZpg4kz8eYuGhsIa043Vwe6", consumerSecret:"Ma7a81ichwAQfRoreeCliipOew56ky7J5GZJ9PQP3HPSYnTDhd")
        
        let net = NetworkReachabilityManager()
        net?.listener = { status in
            if net?.isReachable ?? false
            {
                switch status
                {
                case .reachable(.ethernetOrWiFi):
                    print("#-The network is reachable over the WiFi connection")
                    
                    isNetworkReachable = true
                    NotificationCenter.default.post(name: Notification.Name("notifyIntetnetStatus"), object: true)
                    
                case .reachable(.wwan):
                    print("#-The network is reachable over the WWAN connection")
                    
                    isNetworkReachable = true
                    NotificationCenter.default.post(name: Notification.Name("notifyIntetnetStatus"), object: true)
                    
                case .notReachable:
                    print("#-The network is not reachable")
                    
                    isNetworkReachable = false
                    NotificationCenter.default.post(name: Notification.Name("notifyIntetnetStatus"), object: false)
                case .unknown :
                    print("#-The network is unknown whether it is reachable or not")
                    
                    isNetworkReachable = false
                    NotificationCenter.default.post(name: Notification.Name("notifyIntetnetStatus"), object: false)
                }
            }
            else
            {
                print("#-The network is not reachable")
                
                isNetworkReachable = false
                NotificationCenter.default.post(name: Notification.Name("notifyIntetnetStatus"), object: false)
            }
        }
        net?.startListening()
        MOLHLanguage.setDefaultLanguage("ar")
        MOLH.shared.specialKeyWords = ["Cancel","Done"]
        MOLH.shared.activate(true)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        let appId: String = Settings.appID
        if url.scheme != nil && url.scheme!.hasPrefix("fb\(appId)") && url.host ==  "authorize" {
            return ApplicationDelegate.shared.application(app, open: url, options: options)
        }
        return TWTRTwitter.sharedInstance().application(app, open: url, options: options)
    }
    
    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        if (extensionPointIdentifier == UIApplication.ExtensionPointIdentifier.keyboard) {
            return false
        }
        return true
    }
    
    
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        var handle: Bool = true
        let options: [String: AnyObject] = [UIApplication.OpenURLOptionsKey.sourceApplication.rawValue: sourceApplication as AnyObject, UIApplication.OpenURLOptionsKey.annotation.rawValue: annotation as AnyObject]
        
        handle = TWTRTwitter.sharedInstance().application(application, open: url, options: options)
        
        return handle
    }
   
}

extension String {
    var localized : String {
        return NSLocalizedString(self, comment: "")
    }
}
