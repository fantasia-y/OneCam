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
    @EnvironmentObject var viewModel: GroupViewModel
    @Namespace var namespace
    
    let image: GroupImage
    let group: Group
    
    var body: some View {
        CachedAsyncImage(url: URL(string: image.urls[FilterType.thumbnail.rawValue]!)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                Button {
                    viewModel.selectedImage = self.image
                    viewModel.showCarousel = true
                } label: {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .contextMenu {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                Task {
                                    await viewModel.deleteImage(self.image, group: group)
                                }
                            }
                        } preview: {
                            CachedAsyncImage(url: URL(string: self.image.urls[FilterType.none.rawValue]!)) { contextPhase in
                                switch contextPhase {
                                case .empty:
                                    ZStack {
                                        Rectangle()
                                            .fill(.gray)
                                            .frame(minWidth: 300, minHeight: 300)
                                        
                                        ProgressView()
                                    }
                                case .success(let contextImage):
                                    contextImage
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                case .failure:
                                    ZStack {
                                        Rectangle()
                                            .fill(.gray)
                                        
                                        Image(systemName: "exclamationmark.triangle")
                                            .foregroundStyle(.white)
                                    }
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                }
                .matchedGeometryEffect(id: self.image.id, in: namespace)
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
