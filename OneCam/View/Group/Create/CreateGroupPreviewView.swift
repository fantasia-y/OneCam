//
//  CreateGroupPreviewView.swift
//  OneCam
//
//  Created by Gordon on 09.02.24.
//

import SwiftUI

struct CreateGroupPreviewView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: CreateGroupViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Like what you see?")
                .frame(maxWidth: .infinity)
            
            PreviewGroupView(image: viewModel.image, name: viewModel.groupName)
            
            Spacer()
            
            HStack {
                Button("Back") {
                    withAnimation {
                        viewModel.page -= 1
                    }
                }
                .secondary()
                
                AsyncButton("Create") {
                    await viewModel.publish()
                    dismiss()
                }
                .primary()
            }
        }
        .padding()
    }
}

#Preview {
    CreateGroupPreviewView()
        .environmentObject(CreateGroupViewModel())
}
