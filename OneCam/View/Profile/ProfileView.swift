//
//  ProfileView.swift
//  OneCam
//
//  Created by Gordon on 24.01.24.
//

import SwiftUI
import UIKit

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authenticatedViewModel: AuthenticatedViewModel
    
    @State var newImage: UIImage?
    @State var isLoading = false
    
    let user: User?
    
    var body: some View {
        SheetWrapper { _ in
            VStack(spacing: 5) {
                AvatarPicker(image: $newImage, loadUserImage: true, isLoading: isLoading)
                    .onChange(of: newImage) {
                        // TODO upload image
                        isLoading = true
                        print("new image")
                    }
                
                Text(user?.displayname ?? "Displayname")
                    .bold()
                
                Text(user?.email ?? "E-Mail")
                    .foregroundStyle(.gray)
                
                Spacer()
                
                AsyncButton("Logout") {
                    await authenticatedViewModel.logout()
                    dismiss()
                }
                .destructive()
            }
        }
    }
}

#Preview {
    ProfileView(user: User.Example)
        .environmentObject(AuthenticatedViewModel())
}
