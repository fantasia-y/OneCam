//
//  CreateSession.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import SwiftUI

struct CreateSessionView: View {
    @StateObject var viewModel = CreateSessionViewModel()
    
    @Binding var showCreateSession: Bool
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            VStack {
                CustomTextField("Session name", text: $viewModel.sessionName)
                
                NavigationLink("Next") {
                    CreateSessionSettingsView(showCreateSession: $showCreateSession)
                        .environmentObject(viewModel)
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.sessionName.isEmpty)
            }
            .navigationDestination(for: Session.self) { session in
                ShareSessionView(session: session)
                    .navigationBarBackButtonHidden()
                    .toolbar() {
                        Button("Close") {
                            showCreateSession = false
                        }
                    }
            }
            .toolbar() {
                Button("Cancel") {
                    showCreateSession = false
                }
            }
        }
    }
}

#Preview {
    CreateSessionView(showCreateSession: .constant(true))
}
