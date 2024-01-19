//
//  AppDelegate.swift
//  SampleOfApp
//
//  Created by Macbook on 18/01/2024.
//

import FirebaseCore
import FirebaseAuth
import Firebase
import UIKit
import GoogleSignIn
import GoogleUtilities
import SVProgressHUD
@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
    
        let config = GIDConfiguration.init(clientID: "1033637812380-4hg7oar92jot70667pc8aik6a3hukafb.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.configuration = config
      
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setMaximumDismissTimeInterval(2)
        self.window = UIWindow(frame: UIScreen.main.bounds)
      //  GIDSignIn.sharedInstance().delegate = self
        
        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {

        return GIDSignIn.sharedInstance.handle(url)
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


}



