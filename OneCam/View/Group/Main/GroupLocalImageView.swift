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
            Image(uiImage: UIImage(data: image.image)!)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 200, maxHeight: 200)
                .contentShape(Rectangle())
                .clipped()
            
            Image(systemName: "arrow.triangle.2.circlepath.icloud.fill")
                .foregroundStyle(.white)
                .font(.system(size: 20))
                .shadow(radius: 4)
                .padding(4)
        }
    }
}
