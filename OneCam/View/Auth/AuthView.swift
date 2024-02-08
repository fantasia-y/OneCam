//
//  LoginView.swift
//  CoLiving
//
//  Created by Gordon on 14.12.22.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel: AuthenticatedViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to OneCam")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 25)
            
            Text("Get started by creating or logging into an account")
                .multilineTextAlignment(.center)
            
            CustomTextField("E-Mail", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            
            CustomSecureField("Password", text: $viewModel.password)
            
            HStack {
                CustomButton("Log in") {
                    await viewModel.login()
                }
                .style(.secondary)
                
                CustomButton("Sign up") {
                    await viewModel.register()
                }
            }
            
            HStack {
                VStack { Divider() }
                Text("or")
                VStack { Divider() }
            }
            .padding()
            
            ThirdPartyLoginView()
            
            Spacer()
            
            Text("By continuing you agree to our Terms of Service and Privacy Policy")
                .font(.footnote)
                .foregroundStyle(Color("textSecondary"))
        }
        .padding()
    }
}

#Preview {
    AuthView()
        .environmentObject(AuthenticatedViewModel())
}
