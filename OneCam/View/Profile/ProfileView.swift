//
//  ProfileView.swift
//  OneCam
//
//  Created by Gordon on 24.01.24.
//

import SwiftUI
import UIKit

struct ProfileView: View {
    @EnvironmentObject var authenticatedViewModel: AuthenticatedViewModel
    
    @State var newImage: UIImage?
    @State var isLoading = false
    
    let user: User?
    var showProfile: Binding<Bool>
    
    init(user: User?, showProfile: Binding<Bool>) {
        self.user = user
        self.showProfile = showProfile
    }
    
    init(user: User?) {
        self.user = user
        self.showProfile = .constant(false)
    }
    
    var body: some View {
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
        }
        .padding()
        
        Spacer()
        
        Button("Logout") {
            Task {
                await authenticatedViewModel.logout()
                showProfile.wrappedValue = false
            }
        }
    }
}

#Preview {
    ProfileView(user: User.Example)
}
