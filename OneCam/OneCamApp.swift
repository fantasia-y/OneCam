//
//  OneCamApp.swift
//  OneCam
//
//  Created by Gordon on 31.10.23.
//

import SwiftUI

@main
struct OneCamApp: App {
    var body: some Scene {
        WindowGroup {
            AuthenticatedView() {
                Text("You need to log in")
            } content: {
                ContentView()
            }
        }
    }
}
