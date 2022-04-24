//
//  AppDelegate.swift
//  webViewExample
//
//  Created by dinh thanh an on 2022/04/05.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window?.makeKeyAndVisible()
    window?.rootViewController = UINavigationController(
      rootViewController: ViewController(url: URL(string: "https://minacolor.com/")!)
    )
    return true
  }
}

