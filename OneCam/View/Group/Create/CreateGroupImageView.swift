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
        GeometryReader { geometry in
            VStack(spacing: 20) {
                Text("Next, let's choose a profile image")
                
                Spacer()
                
                Button {
                    viewModel.showImageSelection = true
                } label: {
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .groupPreview(width: geometry.size.width)
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("buttonSecondary"))
                            
                            Image(systemName: "plus")
                                .foregroundStyle(Color("textPrimary"))
                                .bold()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.width * 1.25)
                    }
                }
                .onChange(of: viewModel.pickedItem) {
                    Task {
                        if let loaded = try? await viewModel.pickedItem?.loadTransferable(type: Data.self) {
                            viewModel.image = UIImage(data: loaded)!
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
                    ImagePicker(selectedImage: $viewModel.image)
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
        }
        .padding(.horizontal)
    }
}

#Preview {
    CreateGroupImageView()
        .environmentObject(CreateGroupViewModel())
}
