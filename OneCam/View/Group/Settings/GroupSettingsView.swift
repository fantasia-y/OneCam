//
//  GroupSettingsView.swift
//  OneCam
//
//  Created by Gordon on 24.01.24.
//

import SwiftUI

struct GroupSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var viewModel = GroupSettingsViewModel()
    
    @State var group: Group
    
    var body: some View {
        SheetWrapper(title: "Settings") { path in
            VStack(alignment: .leading) {
                PreviewGroupView(group: group, size: .list) {
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil")
                            .bold()
                            .font(.system(size: 20))
                            .foregroundStyle(.textPrimary)
                    }
                }

                Text("Members")
                    .bold()
                    .padding(.top, 15)
                
                GroupSettingsUserListView(group: group, path: path, truncate: true)
                    .confirmationDialog("Are you sure you want to remove this user from the group?", isPresented: $viewModel.showRemoveDialog, titleVisibility: .visible) {
                        Button("Remove", role: .destructive) {
                            Task {
                                if let removedUser = await viewModel.removeSelectedUserFrom(group: group) {
                                    if let group = homeViewModel.remove(user: removedUser, fromGroup: group) {
                                        self.group = group // TODO update ui
                                    }
                                }
                            }
                        }
                    }
                    .navigationDestination(for: Group.self) { group in
                        ScrollView {
                            GroupSettingsUserListView(group: group, path: path)
                                .padding()
                        }
                        .navigationBarTitleDisplayMode(.inline)
                    }
                
                Spacer()
                
                if let user = userData.currentUser {
                    Button("Leave") {
                        viewModel.showLeaveDialog = true
                    }
                    .destructive()
                    .confirmationDialog("Are you sure you want to leave this group?", isPresented: $viewModel.showLeaveDialog, titleVisibility: .visible) {
                        Button("Leave", role: .destructive) {
                            Task {
                                if await homeViewModel.leaveGroup(group, user: user) {
                                    dismiss()
                                }
                            }
                        }
                    }
                    
                    if group.isOwner(user) {
                        Button("Delete") {
                            viewModel.showDeleteDialog = true
                        }
                        .destructive()
                        .confirmationDialog("Are you sure you want to delete this group?", isPresented: $viewModel.showDeleteDialog, titleVisibility: .visible) {
                            Button("Delete", role: .destructive) {
                                Task {
                                    if await homeViewModel.deleteGroup(group) {
                                        dismiss()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    GroupSettingsView(group: Group.Example)
        .environmentObject(UserData(currentUser: User.Example))
        .environmentObject(HomeViewModel())
}
