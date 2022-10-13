//
//  AppDelegate.swift
//  DestinationFiltersExample
//
//  Created by Prayansh Srivastava on 9/21/22.
//

import UIKit
import Segment
import DestinationFilters_Swift

extension Analytics {
    static let config = Configuration(writeKey: "93EMLzmXzP6EJ3cJOhdaAgEVNnZjwRqA")
        .flushAt(1)
        .trackApplicationLifecycleEvents(true)
    
    static var main = Analytics(configuration: config)
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var analytics: Analytics? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Analytics.main.add(plugin: WebhookDestination(webhookUrl: "https://webhook.site/c6349c6a-bc14-49be-9677-0c8df3e07b58"))
        Analytics.main.add(plugin: DestinationFilters())
        
        Analytics.main.track(name: "howdy doody")
        return true
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

