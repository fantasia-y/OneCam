//
//  AuthView.swift
//  CoLiving
//
//  Created by Gordon on 14.12.22.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel: AuthenticatedViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            switch viewModel.authenticationFlow {
            case .login:
                LoginView()
            case .signup:
                SignUpView()
            }
            
            HStack {
                VStack { Divider() }
                Text("or")
                VStack { Divider() }
            }
            .padding()
            
            ThirdPartyLoginView()
            
            Spacer()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(AuthenticatedViewModel())
    }
}
