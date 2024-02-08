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
    
    var body: some View {
        VStack {
            AvatarPicker(image: $viewModel.image, displayname: viewModel.displaynameDebounced)
            
            CustomTextField("Name", text: $viewModel.displayname)
            
            Button("Save") {
                Task {
                    await contentViewModel.updateUser(viewModel.displayname, viewModel.image)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.displayname.isEmpty)
        }
    }
}

#Preview {
    AccountSetupView()
}
