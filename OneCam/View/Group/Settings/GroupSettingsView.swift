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
    
    let group: Group
    
    var participantListNum: Int {
        min(3, group.participants.count)
    }
    
    struct Cell: View {
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
                }
            }
            .padding(.all, 12)
        }
    }
    
    var body: some View {
        SheetWrapper(title: "Settings") {
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
                
                VStack(spacing: 0) {
                    Cell(group: group, user: group.owner)
                    
                    ForEach(group.participants[..<participantListNum].indices, id: \.self) { index in
                        VStack { Divider() }
                            .padding(.horizontal, 12)
                        
                        Cell(group: group, user: group.participants[index])
                    }
                    
                    if participantListNum < group.participants.count {
                        VStack { Divider() }
                            .padding(.horizontal, 12)
                        
                        Button {
                            
                        } label: {
                            HStack {
                                Text("Show all...")
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                        }
                        .padding()
                        .foregroundStyle(Color("textSecondary"))
                    }
                }
                .background(Color("buttonSecondary"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                
                if let user = userData.currentUser {
                    AsyncButton("Leave") {
                        if await viewModel.leaveGroup(group, user: user) {
                            dismiss()
                            homeViewModel.groups.removeAll(where: { $0.id == group.id })
                            homeViewModel.path.removeLast()
                        }
                    }
                    .destructive()
                    
                    if group.isOwner(user) {
                        AsyncButton("Delete") {
                            
                        }
                        .destructive()
                    }
                }
            }
        }
    }
}

#Preview {
    GroupSettingsView(group: Group.Example)
        .environmentObject(UserData(currentUser: User.Example))
        .environmentObject(HomeViewModel())
}
