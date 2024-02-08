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
        ZStack(alignment: .bottomLeading) {
            Image(uiImage: ImageUtils.cropRectangleImage(UIImage(imageLiteralResourceName: "test_image")))
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(group.name)
                        .bold()
                    
                    Text("\(group.imageCount) image\(group.imageCount != 1 ? "s" : "")")
                        .font(.subheadline)
                        .foregroundStyle(Color("textSecondary"))
                }
                
                Spacer()
            }
            .padding()
            .background(.thinMaterial)
            .frame(maxWidth: .infinity)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    GroupListView(group: Group.Example)
}
