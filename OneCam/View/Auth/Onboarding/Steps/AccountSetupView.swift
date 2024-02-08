//
//  AccountSetupView.swift
//  OneCam
//
//  Created by Gordon on 07.02.24.
//

import SwiftUI
import PhotosUI

struct AccountSetupView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel
    @StateObject var viewModel = AccountSetupViewModel()
    
    let onFinish: () -> ()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Step by step")
                .font(.title)
                .bold()
                .padding(.top, 25)
            
            Text("Let's start by setting up your profile")
                .padding(.bottom, 25)
            
            AvatarPicker(image: $viewModel.image, displayname: viewModel.displaynameDebounced)
            
            CustomTextField("Name", text: $viewModel.displayname)
            
            Spacer()
            
            CustomButton("Next", loading: contentViewModel.loadingUserUpdate) {
                await contentViewModel.updateUser(viewModel.displayname, viewModel.image, completion: onFinish)
            }
            .disabled(viewModel.displayname.isEmpty)
        }
        .padding()
    }
}

#Preview {
    AccountSetupView() {
        
    }
    .environmentObject(ContentViewModel())
}
