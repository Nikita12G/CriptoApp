//
//  AppDelegate.swift
//  CryptoApp
//
//  Created by Никита Гуляев on 23.02.2022.
//

import UIKit

@available(iOS 13.0.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        let basicViewController = BasicViewController()
        
        navigationController.viewControllers = [basicViewController]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

