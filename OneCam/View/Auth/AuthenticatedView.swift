//
//  AuthenticatedView.swift
//  CoLiving
//
//  Created by Gordon on 14.12.22.
//

import SwiftUI

struct AuthenticatedView<Unauthenticated: View, Content: View>: View {
    @StateObject var viewModel = AuthenticatedViewModel()
    
    let unauthenticated: Unauthenticated
    let content: Content
    
    init(@ViewBuilder unauthenticatedBuilder: () -> Unauthenticated, @ViewBuilder content contentBuilder: () -> Content) {
        self.unauthenticated = unauthenticatedBuilder()
        self.content = contentBuilder()
    }
    
    var body: some View {
        VStack {
            switch viewModel.authenticationState {
            case .unauthenticated, .authenticating:
                VStack {
                    unauthenticated
                        .sheet(isPresented: $viewModel.showLoginScreen) {
                            AuthView()
                                .environmentObject(viewModel)
                        }
                    
                    Button {
                        viewModel.showLoginScreen = true
                    } label: {
                        Text("Log in")
                    }
                }
            case .authenticated:
                VStack {
                    content
                        .environmentObject(viewModel)
                }
            }
        }
        .onAppear {
            viewModel.checkAccessToken()
        }
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedView() {
            Text("You need to log in")
        } content: {
            Text("You are logged in")
        }
    }
}
