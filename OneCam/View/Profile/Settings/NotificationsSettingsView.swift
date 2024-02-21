//
//  NotificationsSettingsView.swift
//  OneCam
//
//  Created by Gordon on 20.02.24.
//

import SwiftUI

struct NotificationsSettingsView: View {
    @EnvironmentObject var notificationSettings: LocalNotificationsSettings
    
    var body: some View {
        VStack(spacing: 25) {
            VStack(alignment: .leading) {
                Card {
                    Toggle("New images", isOn: $notificationSettings.newImage)
                        .padding()
                }
                
                Text("A new images was added to group")
                    .font(.subheadline)
                    .foregroundStyle(Color("textSecondary"))
            }
            
            VStack(alignment: .leading) {
                Card {
                    Toggle("New group members", isOn: $notificationSettings.newMember)
                        .padding()
                }
                
                Text("Gordon joined group")
                    .font(.subheadline)
                    .foregroundStyle(Color("textSecondary"))
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NotificationsSettingsView()
}
