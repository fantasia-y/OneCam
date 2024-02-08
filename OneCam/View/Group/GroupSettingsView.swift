//
//  GroupSettingsView.swift
//  OneCam
//
//  Created by Gordon on 24.01.24.
//

import SwiftUI

struct GroupSettingsView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var viewModel = GroupSettingsViewModel()
    
    let group: Group
    @Binding var showSettings: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Avatar
            
            // participant list
            List {
                ForEach(group.participants) { participant in
                    HStack {
                        Avatar(user: participant)
                        
                        Text(participant.displayname ?? "")
                    }
                }
            }
            .scrollDisabled(true)
            
            if let user = userData.currentUser {
                List {
                    Button("Leave Group", role: .destructive) {
                        Task {
                            if await viewModel.leaveGroup(group, user: user) {
                                showSettings = false
                                homeViewModel.groups.removeAll(where: { $0.id == group.id })
                                homeViewModel.path.removeLast()
                            }
                        }
                    }
                    
                    if group.isOwner(user) {
                        Button("Delete Group", role: .destructive) {
                            
                        }
                    }
                }
                .scrollDisabled(true)
            }
        }
    }
}

#Preview {
    GroupSettingsView(group: Group.Example, showSettings: .constant(false))
        .environmentObject(UserData(currentUser: User.Example))
        .environmentObject(HomeViewModel())
}
