//
//  OneCamApp.swift
//  OneCam
//
//  Created by Gordon on 31.10.23.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin
import PushNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        PushNotifications.shared.start(instanceId: "ffb55783-058c-4870-b74e-7c389327098c")
        PushNotifications.shared.registerForRemoteNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        PushNotifications.shared.registerDeviceToken(deviceToken)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        PushNotifications.shared.handleNotification(userInfo: userInfo)

        completionHandler(.noData)
    }
}

@main
struct OneCamApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var colorSchemeSetting = ColorSchemeSetting()
    
    init() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            try Amplify.configure()
        } catch {
            print(error)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            AuthenticatedView() {
                GetStartedView()
            } content: {
                ContentView()
            }
            .preferredColorScheme(colorSchemeSetting.colorScheme)
            .environmentObject(colorSchemeSetting)
        }
    }
}
