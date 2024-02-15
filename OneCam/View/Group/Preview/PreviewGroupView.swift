//
//  GroupPreviewView.swift
//  OneCam
//
//  Created by Gordon on 15.02.24.
//

import SwiftUI
import CachedAsyncImage

enum GroupPreviewType {
    case large
    case list
}

struct PreviewGroupView: View {
    let image: UIImage?
    let name: String
    let imageCount: Int
    let group: Group?
    let size: GroupPreviewType
    
    init(image: UIImage?, name: String, size: GroupPreviewType = .large) {
        self.image = image
        self.name = name
        self.imageCount = 0
        self.group = nil
        self.size = size
    }
    
    init(group: Group, size: GroupPreviewType = .large) {
        self.image = nil
        self.name = group.name
        self.imageCount = group.imageCount
        self.group = group
        self.size = size
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                if let group {
                    CachedAsyncImage(url: URL(string: group.urls[FilterType.none.rawValue]!)!) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("buttonSecondary"))
                                    .if(size == .large) { view in
                                        view.frame(width: geometry.size.width, height: geometry.size.width * 1.25)
                                    }
                                    .if(size == .list) { view in
                                        view.frame(height: 180)
                                    }
                                
                                ProgressView()
                            }
                        case .success(let image):
                            image
                                .groupPreview(width: geometry.size.width, size: size)
                        case .failure:
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("buttonSecondary"))
                                
                                Image(systemName: "questionmark")
                                    .foregroundStyle(Color("textPrimary"))
                                    .bold()
                            }
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else if let image {
                    Image(uiImage: image)
                        .groupPreview(width: geometry.size.width, size: size)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(name)
                            .bold()
                        
                        Text("\(imageCount) image\(imageCount != 1 ? "s" : "")")
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
        .if(size == .list) { view in
            view.frame(height: 180)
        }
    }
}

#Preview {
    PreviewGroupView(group: Group.Example)
}
