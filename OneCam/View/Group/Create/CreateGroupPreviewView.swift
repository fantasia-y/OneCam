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
            
            ZStack(alignment: .bottomLeading) {
                if let image = viewModel.croppedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.groupName)
                            .bold()
                        
                        Text("0 images")
                            .font(.subheadline)
                            .foregroundStyle(Color("textSecondary"))
                    }
                    
                    Spacer()
                }
                .padding()
                .background(.thinMaterial)
                .frame(maxWidth: .infinity)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
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
