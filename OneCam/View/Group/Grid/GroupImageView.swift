//
//  GridImageView.swift
//  OneCam
//
//  Created by Gordon on 25.01.24.
//

import SwiftUI
import CachedAsyncImage
import GordonKirschAPI

struct GroupImageView: View {
    let image: GroupImage
    let group: Group
    
    var body: some View {
        // apparently doesnt follow redirect
        CachedAsyncImage(url: URLUtils.generateUrl(forImage: image, andGroup: group)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                ZStack {
                    Rectangle()
                        .fill(.gray)
                        .frame(minWidth: 120, minHeight: 120)
                    
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundStyle(.white)
                }
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    GroupImageView(image: GroupImage.Example, group: Group.Example)
}
