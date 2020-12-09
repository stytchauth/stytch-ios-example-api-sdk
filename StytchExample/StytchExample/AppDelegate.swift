//
//  AppDelegate.swift
//  StytchExample
//
//  Created by Edgar Kroman on 2020-12-08.
//

import UIKit
import Stytch

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let stytchProjectID = "project-test-d0dbafe6-a019-47ea-8550-d021c1c76ea9"
    let stytchSecretKey = "secret-test-6-ma0PNENqjBVX6Dx2aPUIdhLFObauXx07c="

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Stytch.shared.configure(projectID: stytchProjectID, secret: stytchSecretKey, scheme: "stytchexample", host: "stytch.com")
        
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return Stytch.shared.handleMagicLinkUrl(userActivity.webpageURL)
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return Stytch.shared.handleMagicLinkUrl(url)
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return Stytch.shared.handleMagicLinkUrl(url)
    }

}

