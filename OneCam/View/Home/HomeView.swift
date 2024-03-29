//
//  HomeView.swift
//  OneCam
//
//  Created by Gordon on 12.12.23.
//

import SwiftUI
import CachedAsyncImage

struct HomeView: View {
    @EnvironmentObject var userData: UserData
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        if !viewModel.initialLoad {
            NavigationStack(path: $viewModel.path) {                
                VStack {
                    if viewModel.groups.isEmpty {
                        VStack {
                            Spacer()
                            
                            Button("Create Group") {
                                viewModel.showCreateGroup = true
                            }
                            .primary()
                            
                            Button("Join Group") {
                                viewModel.showCodeScanner = true
                            }
                            .secondary()
                        }
                        .padding()
                    }
                    
                    if !viewModel.groups.isEmpty {
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(viewModel.groups) { group in
                                    NavigationLink(value: group) {
                                        PreviewGroupView(group: group, size: .list)
                                    }
                                    .buttonStyle(.plain)
                                    .contextMenu() {
                                        ShareLink(item: URLUtils.generateShareUrl(forGroup: group))
                                        
                                        Button("Share QR Code...", systemImage: "qrcode") {
                                            viewModel.showShareGroup = true
                                        }
                                        
                                        Button("Leave", systemImage: "rectangle.portrait.and.arrow.right", role: .destructive) {
                                            viewModel.showLeaveDialog = true
                                            viewModel.selectedGroup = group
                                        }
                                        
                                        if let currentUser = userData.currentUser, group.isOwner(currentUser) {
                                            Button("Delete", systemImage: "trash", role: .destructive) {
                                                viewModel.showDeleteDialog = true
                                                viewModel.selectedGroup = group
                                            }
                                        }
                                    }
                                    .sheet(isPresented: $viewModel.showShareGroup) {
                                        ShareGroupView(group: group)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .refreshable {
                            Task {
                                await viewModel.getGroups()
                            }
                        }
                    }
                    
                    Spacer()

                }
                .navigationTitle("Groups")
                .navigationBarTitleDisplayMode(.large)
                .navigationDestination(for: Group.self) { group in
                    GroupView(group: group)
                        .navigationBarTitleDisplayMode(.inline)
                }
                .sheet(isPresented: $viewModel.showCreateGroup) {
                    CreateGroupView()
                }
                .sheet(isPresented: $viewModel.showCodeScanner) {
                    JoinGroupView()
                }
                .sheet(isPresented: $viewModel.showProfile) {
                    ProfileView()
                }
                .confirmationDialog("Are you sure you want to leave this group?", isPresented: $viewModel.showLeaveDialog, titleVisibility: .visible) {
                    Button("Leave", role: .destructive) {
                        Task {
                            if let currentUser = userData.currentUser, let group = viewModel.selectedGroup {
                                if await viewModel.leaveGroup(group, user: currentUser) {
                                    viewModel.selectedGroup = nil
                                }
                            }
                        }
                    }
                }
                .confirmationDialog("Are you sure you want to delete this group?", isPresented: $viewModel.showDeleteDialog, titleVisibility: .visible) {
                    Button("Delete", role: .destructive) {
                        Task {
                            if let group = viewModel.selectedGroup {
                                if await viewModel.deleteGroup(group) {
                                    viewModel.selectedGroup = nil
                                }
                            }
                        }
                    }
                }
                .toolbar() {
                    if !viewModel.groups.isEmpty {
                        Button {
                            viewModel.showCreateGroup = true
                        } label: {
                            Image(systemName: "plus")
                        }
                        
                        Button {
                            viewModel.showCodeScanner = true
                        } label: {
                            Image(systemName: "person.badge.plus")
                        }
                    }
                    
                    Button {
                        viewModel.showProfile = true
                    } label: {
                        Avatar(user: userData.currentUser, filter: FilterType.thumbnail)
                    }
                }
            }
            .environmentObject(viewModel)
            .toastView(toast: $viewModel.toast)
        } else {
            ProgressView()
                .onAppear() {
                    Task {
                        await viewModel.getGroups()
                    }
                }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(UserData())
    }
}
