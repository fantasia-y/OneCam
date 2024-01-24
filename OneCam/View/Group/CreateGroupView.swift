//
//  CreateSession.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import SwiftUI

struct CreateGroupView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var viewModel = CreateGroupViewModel()
    
    @Binding var showCreateGroup: Bool
    @State var showPreview: Bool = false
    
    var body: some View {
        VStack {
            CustomTextField("Group name", text: $viewModel.groupName)
            
            Button("Create Group", systemImage: "plus") {
                Task {
                    // TODO show preview before publishing
                    await viewModel.publish()
                    if let group = viewModel.group {
                        homeViewModel.groups.append(group)
                        showCreateGroup = false
                    }
                }
            }
        }
        .sheet(isPresented: $showPreview) {
            PreviewCreateGroupView(showCreateGroup: $showCreateGroup, group: viewModel.group!)
                .toolbar() {
                    Button("Cancel") {
                        showCreateGroup = false
                    }
                }
        }
        .toolbar() {
            Button("Cancel") {
                showCreateGroup = false
            }
        }
    }
}

#Preview {
    CreateGroupView(showCreateGroup: .constant(true))
}
