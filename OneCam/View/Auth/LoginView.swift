//
//  LoginView.swift
//  CoLiving
//
//  Created by Gordon on 14.12.22.
//

import SwiftUI

struct IndexResponse: Decodable {
    var hello: String
}

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthenticatedViewModel
    
    var body: some View {
        VStack {
            Text("Log In")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            CustomTextField("E-Mail", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
            
            CustomSecureField("Password", text: $viewModel.password)
            
            Button() {
                Task {
                    await viewModel.login()
                }
            } label: {
                Text("Log In")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(6)
            
            Button() {
                viewModel.switchFlow()
            } label: {
                Text("Don't have an account yet?")
            }
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticatedViewModel())
    }
}
