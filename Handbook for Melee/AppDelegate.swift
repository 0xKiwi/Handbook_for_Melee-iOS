//
//  AppDelegate.swift
//  Tab example
//
//  Created by Ivan Martinez on 12/25/16.
//  Copyright © 2016 Ivan Martinez. All rights reserved.
//

import UIKit
import Appodeal
import AVFoundation
import SwiftyStoreKit
import Firebase
import SwiftTheme

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var adsRemoved = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Appodeal.initialize(withApiKey: "b88719599466bff10275dedf3571711d66755dc663dd1703", types: AppodealAdType.banner)
        FirebaseApp.configure()
        
        let defaults = UserDefaults.standard
			if defaults.bool(forKey: SettingsViewController.THEME_PREF) {
				ThemeManager.setTheme(index: 1)
			} else {
				ThemeManager.setTheme(index: 0)
			}
        
        defaults.register(defaults: [SettingsViewController.STRETCH_PREF: true])
        defaults.register(defaults: [SettingsViewController.GROUP_PREF: true])
        
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setCategory(AVAudioSessionCategoryPlayback, with: AVAudioSessionCategoryOptions.mixWithOthers) 
        
        SwiftyStoreKit.completeTransactions(atomically: true) { products in
            for product in products {
                if product.transaction.transactionState == .purchased || product.transaction.transactionState == .restored {
                    if product.needsFinishTransaction {
                        let defaults = UserDefaults.standard
                        defaults.set(true, forKey: "adsRemoved")
                        SwiftyStoreKit.finishTransaction(product.transaction)              }
                    print("purchased: \(product)")
                }
            }
        }
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
}

