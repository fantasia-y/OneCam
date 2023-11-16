//
//  CreateSessionSettingsView.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import SwiftUI

struct CreateSessionSettingsView: View {
    @EnvironmentObject var viewModel: CreateSessionViewModel
    
    var body: some View {
        // Cover preview
        
        DatePicker("Valid until", selection: $viewModel.validUntil, displayedComponents: .date)
        
        Picker("Max. participants", selection: $viewModel.maxParticipants) {
            Text("10")
                .tag(10)
            
            Text("20")
                .tag(20)
            
            Text("30")
                .tag(30)
            
            Text("40")
                .tag(40)
            
            Text("50")
                .tag(50)
        }
        
        Toggle(isOn: $viewModel.allowGuests, label: {
            Text("Allow guests")
        })
        
        Button("Publish") {
            Task {
                await viewModel.publish()
            }
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    CreateSessionSettingsView()
}
