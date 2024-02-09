//
//  GroupProfileImageView.swift
//  OneCam
//
//  Created by Gordon on 09.02.24.
//

import SwiftUI

struct CreateGroupImageView: View {
    @EnvironmentObject var viewModel: CreateGroupViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Next, let's choose a profile image")
                .padding(.bottom, 25)
            
            Button {
                viewModel.showImageSelection = true
            } label: {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("buttonSecondary"))
                        
                        Image(systemName: "plus")
                            .foregroundStyle(Color("textPrimary"))
                            .bold()
                    }
                }
            }
            .onChange(of: viewModel.pickedItem) {
                Task {
                    if let loaded = try? await viewModel.pickedItem?.loadTransferable(type: Data.self) {
                        viewModel.image = UIImage(data: loaded)!
                        viewModel.croppedImage = ImageUtils.cropRectangleImage(UIImage(data: loaded)!, orientation: .portrait) // TODO fix
                        viewModel.pickedItem = nil
                    }
                }
            }
            .confirmationDialog("", isPresented: $viewModel.showImageSelection) {
                Button("Camera") {
                    viewModel.showCamera = true
                }
                
                Button("Gallery") {
                    viewModel.showLibrary = true
                }
                
                if let _ = viewModel.image {
                    Button("Remove", role: .destructive) {
                        viewModel.image = nil
                    }
                }
            }
            .photosPicker(isPresented: $viewModel.showLibrary, selection: $viewModel.pickedItem)
            .fullScreenCover(isPresented: $viewModel.showCamera) {
                ImagePicker(selectedImage: $viewModel.image, croppedImage: $viewModel.croppedImage)
                    .background() {
                        Color.black.ignoresSafeArea()
                    }
            }
            
            Spacer()
            
            HStack {
                Button("Back") {
                    withAnimation {
                        viewModel.page -= 1
                    }
                }
                .secondary()
                
                Button("Next") {
                    withAnimation {
                        viewModel.page += 1
                    }
                }
                .primary()
                .disabled(viewModel.image == nil)
            }
        }
        .padding()
    }
}

#Preview {
    CreateGroupImageView()
        .environmentObject(CreateGroupViewModel())
}
