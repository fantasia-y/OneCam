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
                        HStack {
                            Button("Create Group", systemImage: "plus") {
                                viewModel.showCreateGroup = true
                            }
                            .buttonStyle(.borderedProminent)
                            
                            Button("Join Group", systemImage: "plus") {
                                viewModel.showCodeScanner = true
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    
                    if !viewModel.groups.isEmpty {
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(viewModel.groups) { group in
                                    NavigationLink(value: group) {
                                        GroupListView(group: group)
                                    }
                                    .buttonStyle(.plain)
                                    .contextMenu() {
                                        Button("Share", systemImage: "square.and.arrow.up") {
                                            
                                        }
                                        
                                        Button("Leave", systemImage: "rectangle.portrait.and.arrow.right", role: .destructive) {
                                            
                                        }
                                        
                                        Button("Delete", systemImage: "trash", role: .destructive) {
                                            
                                        }
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
                    CreateGroupView(showCreateGroup: $viewModel.showCreateGroup)
                }
                .sheet(isPresented: $viewModel.showCodeScanner) {
                    JoinGroupView(showCodeScanner: $viewModel.showCodeScanner)
                }
                .sheet(isPresented: $viewModel.showProfile) {
                    ProfileView(user: userData.currentUser, showProfile: $viewModel.showProfile)
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
