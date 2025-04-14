//
//  AppDelegate.swift
//  MeliProcess
//
//  Created by Gabriel Ferreira de Carvalho on 05/02/25.
//

import UIKit
import StartUp

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        StartUp.registerDependencies()
        window = StartUp.buildWindow()
        window?.makeKeyAndVisible()
        return true
    }
}
