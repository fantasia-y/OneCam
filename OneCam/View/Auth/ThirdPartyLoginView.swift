//
//  ThirdPartyLoginView.swift
//  CoLiving
//
//  Created by Gordon on 15.12.22.
//

import SwiftUI
import AuthenticationServices

struct ThirdPartyLoginView: View {
    @EnvironmentObject var viewModel: AuthenticatedViewModel
    
    var body: some View {
        VStack {
            SignInWithAppleButton() { request in
                viewModel.handleSignInWithAppleRequest(request)
            } onCompletion: { result in
                viewModel.handleSignInWithAppleCompletion(result)
            }
            .frame(width: 240, height: 45)
            .cornerRadius(6)
            
            Button {
                viewModel.handleGoogleSignIn()
            } label: {
                HStack {
                    Image("google")
                        .resizable()
                        .frame(width: 16, height: 16)
                    
                    Text("Sign in with Google")
                }
            }
            .frame(width: 240, height: 45)
            .buttonStyle(.plain)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke()
            }
        }
    }
}

struct ThirdPartyLoginView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdPartyLoginView()
            .environmentObject(AuthenticatedViewModel())
    }
}
