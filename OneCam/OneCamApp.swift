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

@main
struct OneCamApp: App {
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
        }
    }
}
