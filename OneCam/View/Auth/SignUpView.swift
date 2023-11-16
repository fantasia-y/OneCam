//
//  SignUpView.swift
//  CoLiving
//
//  Created by Gordon on 15.12.22.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthenticatedViewModel
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Image(systemName: "at")
                
                TextField("E-Mail", text: $viewModel.email)
                    .autocapitalization(.none)
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke()
            }
            
            HStack {
                Image(systemName: "key")
                
                SecureField("Password", text: $viewModel.password)
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke()
            }
            
            HStack {
                Image(systemName: "key")
                
                SecureField("Confirm", text: $viewModel.password2)
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke()
            }
            
            Button() {
                Task {
                    await viewModel.register()
                }
            } label: {
                Text("Sign Up")
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
                Text("Already have an account?")
            }
        }
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthenticatedViewModel())
    }
}
