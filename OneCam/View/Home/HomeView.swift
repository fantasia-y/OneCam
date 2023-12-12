//
//  HomeView.swift
//  OneCam
//
//  Created by Gordon on 12.12.23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authenticatedViewModel: AuthenticatedViewModel
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button("Create new session") {
                        viewModel.showCreateSession = true
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $viewModel.showCreateSession) {
                        CreateSessionView(showCreateSession: $viewModel.showCreateSession)
                    }
                    
                    Button("Join session") {
                        viewModel.showCodeScanner = true
                    }
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $viewModel.showCodeScanner) {
                        JoinSessionView(showCodeScanner: $viewModel.showCodeScanner)
                            .environmentObject(viewModel)
                    }
                }
                
                // List sessions
                List(viewModel.sessions) { session in
                    NavigationLink(session.name) {
                        SessionView(session: session)
                    }
                }
                .onAppear() {
                    Task {
                        await viewModel.getSessions()
                    }
                }
                
                Spacer()
                
                // Temp
                HStack {
                    Button("Logout") {
                        Task {
                            await authenticatedViewModel.logout()
                        }
                    }
                    
                    Button("Archive") {
                        
                    }
                }
                .padding()
            }
            .padding()
            .toolbar() {
                Button("Profile") {
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
