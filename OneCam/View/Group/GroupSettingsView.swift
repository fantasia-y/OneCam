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
        VStack {
            if let user = userData.currentUser {
                Button("Leave Group") {
                    Task {
                        if await viewModel.leaveGroup(group, user: user) {
                            showSettings = false
                            homeViewModel.groups.removeAll(where: { $0.id == group.id })
                            homeViewModel.path.removeLast()
                        }
                    }
                }
                
                if group.isOwner(user) {
                    Button("Delete Group") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    GroupSettingsView(group: Group.Example, showSettings: .constant(false))
}
