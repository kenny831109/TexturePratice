//
//  AppDelegate.swift
//  TexturePratice
//
//  Created by 逸唐陳 on 2019/1/30.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.backgroundColor = .lightGray
        let vc = TabBarController()
        window?.rootViewController = vc
        vc.tabBar.barTintColor = .white
        vc.tabBar.isTranslucent = false
        window?.makeKeyAndVisible()
        return true
    }
    
}

