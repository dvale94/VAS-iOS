//
//  AppDelegate.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 9/6/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import KeychainAccess

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let isUserLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
//    static var isUserAdmin: Bool = UserDefaults.standard.bool(forKey: "isUserAdmin")
    static var isUserAdmin: Bool = true
    static let keychain = Keychain(server: "http://commandsapiname.azurewebsites.net/api/", protocolType: .http)

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().tintColor = .gciBlue
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().tintColor = .gciBlue

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor(white: 0.97, alpha: 1)
        window?.rootViewController = isUserLoggedIn ? MainTabBarController(showAdminView: AppDelegate.isUserAdmin) : LoginViewController()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
