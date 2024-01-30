//
//  GroupLocalImageView.swift
//  OneCam
//
//  Created by Gordon on 30.01.24.
//

import SwiftUI

struct GroupLocalImageView: View {
    let image: GroupLocalImage
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(uiImage: image.image)
                .resizable()
                .aspectRatio(1.0, contentMode: .fill)
            
            Image(systemName: "arrow.triangle.2.circlepath.icloud.fill")
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .shadow(radius: 4)
                .padding(4)
        }
    }
}

#Preview {
    GroupLocalImageView(image: .init(group: Group.Example, image: .init(named: "test_image")!))
        .frame(width: 200, height: 200)
}