//
//  JoinGroupPreviewView.swift
//  OneCam
//
//  Created by Gordon on 15.02.24.
//

import SwiftUI

struct JoinGroupPreviewView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: JoinGroupViewModel
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack(spacing: 20) {
            if let group = viewModel.group {
                PreviewGroupView(group: group)
                
                Spacer()
                
                VStack {
                    AsyncButton("Join") {
                        // await viewModel.publish()
                        dismiss()
                    }
                    .primary()
                    .disabled(!viewModel.isJoinable(forUser: userData.currentUser!))
                    
                    if !viewModel.isJoinable(forUser: userData.currentUser!) {
                        Text("You're already part of this group")
                            .font(.subheadline)
                            .foregroundStyle(Color("textSecondary"))
                    }
                }
            } else {
                ProgressView()
            }
        }
        .padding()
        .onAppear() {
            Task {
                await viewModel.getGroup()
            }
        }
    }
}

#Preview {
    JoinGroupPreviewView()
        .environmentObject(JoinGroupViewModel(group: Group.Example))
        .environmentObject(UserData(currentUser: User.Example))
}
