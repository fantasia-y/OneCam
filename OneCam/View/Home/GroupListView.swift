//
//  GroupListView.swift
//  OneCam
//
//  Created by Gordon on 24.01.24.
//

import SwiftUI

struct GroupListView: View {
    let group: Group
    
    var body: some View {
        HStack(alignment: .top) {
            Avatar(imageUrl: "https://images.pexels.com/photos/16153963/pexels-photo-16153963/free-photo-of-flower-heads-floating-in-a-bottled-water.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
                .size(.medium)
            
            VStack(alignment: .leading) {
                Text(group.name)
                    .bold()
                
                Text("\(group.imageCount) Images")
                    .foregroundStyle(.gray)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    GroupListView(group: Group.Example)
}
