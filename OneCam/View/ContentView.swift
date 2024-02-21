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
        if viewModel.isLoaded {
            switch viewModel.onboardingState {
            case .accountSetup:
                OnboardingView()
                    .environmentObject(viewModel)
            case .finished, .emailVerification:
                HomeView()
                    .environmentObject(viewModel.userData)
            }
        } else {
            VStack {
                if !viewModel.failedLoading {
                    ProgressView()
                        .task {
                            let _ = await viewModel.loadUser()
                        }
                } else {
                    VStack(spacing: 20) {
                        Button {
                            Task {
                                if await viewModel.loadUser() {
                                    authenticatedViewModel.onAuthenticated()
                                }
                            }
                        } label: {
                            Label("Try again", systemImage: "arrow.clockwise")
                        }
                        
                        Button {
                            Task {
                                await authenticatedViewModel.logout()
                            }
                        } label: {
                            Label("Logout", systemImage: "multiply.circle.fill")
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
