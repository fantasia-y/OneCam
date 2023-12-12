//
//  PreviewSessionView.swift
//  OneCam
//
//  Created by Gordon on 11.12.23.
//

import SwiftUI

struct PreviewSessionView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var viewModel = PreviewSessionViewModel()
    
    @Binding var showCodeScanner: Bool
    let id: String
    
    var body: some View {
        VStack {
            Text("Session Preview")
            
            if let session = viewModel.session {
                Text("Name: \(session.name)")
                
                Button("Join") {
                    Task {
                        if await viewModel.joinSession(session) {
                            showCodeScanner = false
                            homeViewModel.sessions.append(session)
                        }
                    }
                }
                .disabled(!viewModel.isJoinable(forUser: userData.currentUser!))
            }
        }
        .onAppear() {
            Task {
                await viewModel.getSession(id)
            }
        }
    }
}

#Preview {
    PreviewSessionView(showCodeScanner: .constant(true), id: "c37ea2a3-631f-4d33-a693-83d543995bb1")
}
