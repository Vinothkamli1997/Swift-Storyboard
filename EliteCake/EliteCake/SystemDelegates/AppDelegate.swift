//
//  AppDelegate.swift
//  EliteCake
//
//  Created by Apple - 1 on 05/01/23.
//

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseMessaging
import Firebase
import FirebaseCrashlytics
import GoogleMaps
import GooglePlaces

let client_id = "272799457057-mvanunm9b1j31mdov8vmttn201tqvuil.apps.googleusercontent.com"

//new ClientID
//let client_id = "325429786778-bqtpaceumnppdgt2nl63cl7ed4oi8fro.apps.googleusercontent.com"

//@main
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if UserDefaults.standard.bool(forKey: userDefaultConstant.loggedIn) == true {
            let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BottomViewController")
            let navigation = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = navigation
            self.window?.makeKeyAndVisible()
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController")
            let navigation = UINavigationController(rootViewController: vc)
            self.window?.rootViewController = navigation
            self.window?.makeKeyAndVisible()
        }
        
        // Override point for customization after application launch.
        GIDSignIn.sharedInstance().clientID = client_id
        GIDSignIn.sharedInstance().delegate = self
        
        FirebaseApp.configure()
        
        GMSServices.provideAPIKey("AIzaSyBvHczu30gT9JCj_ej6moPVmBuFI8hMuUE")
        
        GMSPlacesClient.provideAPIKey("AIzaSyBvHczu30gT9JCj_ej6moPVmBuFI8hMuUE")
        
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        
        return true
    }
    
    func application(_ app: UIApplication,
                         open url: URL,
                         options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
            
            return GIDSignIn.sharedInstance().handle(url)
        }
    
    func checkLogin() {
        if UserDefaults.standard.bool(forKey: userDefaultConstant.loggedIn) == true {
            // this line is important
            self.window = UIWindow(frame: UIScreen.main.bounds)

            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}

extension AppDelegate: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!,
              didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        
        // Check for sign in error
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            } else {
                print("\(error)")
            }
            return
        }
        
        UserDefaults.standard.set(user.userID, forKey: "USER_ID")
        UserDefaults.standard.set(user.profile.email, forKey: "EMAIL")
        UserDefaults.standard.set(user.profile.familyName, forKey: "FAMILYNAME")
        UserDefaults.standard.set(user.profile.name, forKey: "FULLNAME")
        UserDefaults.standard.set(user.profile.givenName, forKey: "GIVENNAME")
        

        // Post notification after user successfully sign in
        NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil)
    }
}

// MARK:- Notification names
extension Notification.Name {
    // Notification when user successfully sign in using Google
    static var signInGoogleCompleted: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var addOnDishPriceAdded: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var addOnDishPriceremoved: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var badgeCountUpdate: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var cartScreenUpdate: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var walletScreenUpdate: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var addOnPrice: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var addOnPriceDisselect: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var multiaddOnPrice: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var multiaddOnPriceDisselect: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var addOnDisselect: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var selectedAddOnDish: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var selectedMultipleAddOnDish: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var mergedSelectedAddOnDish: Notification.Name {
        return .init(rawValue: #function)
    }
    
    static var selectSlotID: Notification.Name {
        return .init(rawValue: #function)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // ...
    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
        return [[.alert, .sound, .badge]]
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse) async {
    let userInfo = response.notification.request.content.userInfo

    // ...
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print full message.
    print(userInfo)
  }

    // Silent notifications

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
      -> UIBackgroundFetchResult {
      // If you are receiving a notification message while your app is in the background,
      // this callback will not be fired till the user taps on the notification launching the application.
      // TODO: Handle data of notification
      // With swizzling disabled you must let Messaging know about the message, for Analytics
      // Messaging.messaging().appDidReceiveMessage(userInfo)
      // Print full message.
      print(userInfo)

      return UIBackgroundFetchResult.newData
    }
}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        UserDefaults.standard.set(fcmToken ?? "", forKey: "FCMToken")
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
    
}
