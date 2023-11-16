//
//  CreateSession.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import SwiftUI

struct CreateSessionView: View {
    @StateObject var viewModel = CreateSessionViewModel()
    
    var body: some View {
        NavigationStack {
            CustomTextField("Session name", text: $viewModel.sessionName)
            
            NavigationLink("Next") {
                CreateSessionSettingsView()
                    .environmentObject(viewModel)
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.sessionName.isEmpty)
        }
    }
}

#Preview {
    CreateSessionView()
}
