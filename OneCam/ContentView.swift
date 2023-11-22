//
//  ContentView.swift
//  OneCam
//
//  Created by Gordon on 31.10.23.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    @EnvironmentObject var authenticatedViewModel: AuthenticatedViewModel
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button("Profile") {
                    
                }
            }
            
            Spacer()
            
            Button("Create new session") {
                viewModel.showCreateSession.toggle()
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $viewModel.showCreateSession) {
                CreateSessionView()
            }
            
            Button("Join session") {
                viewModel.showCodeScanner.toggle()
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $viewModel.showCodeScanner) {
                JoinSessionView(showCodeScanner: $viewModel.showCodeScanner)
            }
            
            Spacer()
            
            // List sessions
            
            // Temp
            Button("Logout") {
                Task {
                    await authenticatedViewModel.logout()
                }
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
