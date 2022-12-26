//
//  AppDelegate.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 8/13/22.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setRootViewController()
        
        return true
    }
    
    func setRootViewController(){
        if #available(iOS 13, *) { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = Container.appTabBarController()
        self.window?.makeKeyAndVisible()
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

}

