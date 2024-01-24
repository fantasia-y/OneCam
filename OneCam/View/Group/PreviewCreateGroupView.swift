//
//  PreviewSessionView.swift
//  OneCam
//
//  Created by Gordon on 11.12.23.
//

import SwiftUI

struct PreviewCreateGroupView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var viewModel: CreateGroupViewModel
    
    @Binding var showCreateGroup: Bool
    let group: Group
    
    var body: some View {
        VStack {
            Text("Group Preview")
            
            Text("Name: \(group.name)")
            
            Button("Create Group", systemImage: "plus") {
                Task {
                    await viewModel.publish()
                    showCreateGroup = false
                }
            }
        }
    }
}

#Preview {
    PreviewGroupView(showCodeScanner: .constant(true), id: "c37ea2a3-631f-4d33-a693-83d543995bb1")
}
