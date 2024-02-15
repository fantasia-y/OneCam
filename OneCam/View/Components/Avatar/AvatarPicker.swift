//
//  AvatarPicker.swift
//  OneCam
//
//  Created by Gordon on 07.02.24.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct AvatarPicker: View {
    @EnvironmentObject var userData: UserData
    
    @Binding var image: UIImage?
    var displayname: String?
    var loadUserImage = false
    var isLoading = false
    
    @State var pickedItem: PhotosPickerItem?
    @State var showImageSelection = false
    @State var showCamera = false
    @State var showLibrary = false
    
    var body: some View {
        Button {
            showImageSelection = true
        } label: {
            if let image {
                if loadUserImage {
                    if isLoading {
                        ZStack {
                            Circle()
                                .fill(Color("buttonSecondary"))
                                .frame(width: 128, height: 128)
                            
                            ProgressView()
                        }
                    } else {
                        Avatar(user: userData.currentUser)
                            .size(.large)
                    }
                } else {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 128, height: 128)
                        .clipShape(Circle())
                }
            } else {
                if let displayname, !displayname.isEmpty {
                    Avatar(imageUrl: "https://ui-avatars.com/api/?name=\(displayname)&size=256")
                        .size(.large)
                } else if loadUserImage {
                    Avatar(user: userData.currentUser)
                        .size(.large)
                } else {
                    ZStack {
                        Circle()
                            .fill(Color("buttonSecondary"))
                            .frame(width: 128, height: 128)
                        
                        Image(systemName: "plus")
                            .foregroundStyle(Color("textPrimary"))
                            .bold()
                    }
                }
            }
        }
        .disabled(isLoading)
        .onChange(of: pickedItem) {
            Task {
                if let loaded = try? await pickedItem?.loadTransferable(type: Data.self) {
                    image = UIImage(data: loaded)!
                    pickedItem = nil
                }
            }
        }
        .confirmationDialog("", isPresented: $showImageSelection) {
            Button("Camera") {
                showCamera = true
            }
            
            Button("Gallery") {
                showLibrary = true
            }
            
            if let _ = image, !loadUserImage {
                Button("Remove", role: .destructive) {
                    image = nil
                }
            }
        }
        .photosPicker(isPresented: $showLibrary, selection: $pickedItem)
        .fullScreenCover(isPresented: $showCamera) {
            ImagePicker(selectedImage: $image)
                .background() {
                    Color.black.ignoresSafeArea()
                }
        }
    }
}
