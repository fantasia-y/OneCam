//
//  GroupUserCellView.swift
//  OneCam
//
//  Created by Gordon on 19.02.24.
//

import SwiftUI

struct GroupUserCellView: View {
    @EnvironmentObject var viewModel: GroupSettingsViewModel
    
    let group: Group
    let user: User
    
    var body: some View {
        HStack {
            Avatar(user: user)
            
            Text(user.displayname ?? "")
            
            Spacer()
            
            if group.isOwner(user) {
                Text("Owner")
                    .foregroundStyle(Color("textSecondary"))
            } else {
                Menu {
                    Button("Remove", systemImage: "trash", role: .destructive) {
                        viewModel.showRemoveDialog = true
                        viewModel.selectedUser = user
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(Color("textSecondary"))
                }
            }
        }
        .padding(.all, 12)
    }
}

#Preview {
    GroupUserCellView(group: Group.Example, user: User.Example)
        .environmentObject(GroupSettingsViewModel())
}
