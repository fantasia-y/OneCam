//
//  PreviewSessionView.swift
//  OneCam
//
//  Created by Gordon on 11.12.23.
//

import SwiftUI

struct PreviewGroupView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var viewModel = PreviewGroupViewModel()
    
    @Binding var showCodeScanner: Bool
    let id: String
    
    var body: some View {
        VStack {
            Text("Group Preview")
            
            if let group = viewModel.group {
                Text("Name: \(group.name)")
                
                Button("Join") {
                    Task {
                        if await viewModel.joinGroup(group) {
                            showCodeScanner = false
                            homeViewModel.groups.append(group)
                        }
                    }
                }
                .disabled(!viewModel.isJoinable(forUser: userData.currentUser!))
            }
        }
        .onAppear() {
            Task {
                await viewModel.getGroup(id)
            }
        }
    }
}

#Preview {
    PreviewGroupView(showCodeScanner: .constant(true), id: "c37ea2a3-631f-4d33-a693-83d543995bb1")
}
