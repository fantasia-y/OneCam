//
//  GroupNameView.swift
//  OneCam
//
//  Created by Gordon on 09.02.24.
//

import SwiftUI

struct CreateGroupNameView: View {
    @EnvironmentObject var viewModel: CreateGroupViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Let's start by choosing a name")
                .padding(.bottom, 25)
            
            CustomTextField("Name", text: $viewModel.groupName)
            
            Spacer()
            
            AsyncButton("Next") {
                hideKeyboard()
                
                withAnimation {
                    viewModel.page += 1
                }
            }
            .primary()
            .disabled(viewModel.groupName.isEmpty)
        }
        .padding()
    }
}

#Preview {
    CreateGroupNameView()
        .environmentObject(CreateGroupViewModel())
}
