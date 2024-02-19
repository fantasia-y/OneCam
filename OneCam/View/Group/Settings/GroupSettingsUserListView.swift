//
//  GroupSettingsUserListView.swift
//  OneCam
//
//  Created by Gordon on 19.02.24.
//

import SwiftUI

struct GroupSettingsUserListView: View {
    let group: Group
    let path: Binding<NavigationPath>
    var truncate = false
    
    var participantListNum: Int {
        min(3, group.participants.count)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            GroupUserCellView(group: group, user: group.owner)
            
            if truncate {
                ForEach(group.participants[..<participantListNum].indices, id: \.self) { index in
                    VStack { Divider() }
                        .padding(.horizontal, 12)
                    
                    GroupUserCellView(group: group, user: group.participants[index])
                }
            } else {
                ForEach(group.participants) { participant in
                    VStack { Divider() }
                        .padding(.horizontal, 12)
                    
                    GroupUserCellView(group: group, user: participant)
                }
            }
            
            
            if participantListNum < group.participants.count, truncate {
                VStack { Divider() }
                    .padding(.horizontal, 12)
                
                Button {
                    path.wrappedValue.append(group)
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
    }
}

#Preview {
    GroupSettingsUserListView(group: Group.Example, path: .constant(NavigationPath()))
}
