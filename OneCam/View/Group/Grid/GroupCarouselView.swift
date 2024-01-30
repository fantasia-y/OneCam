//
//  GroupCarouselView.swift
//  OneCam
//
//  Created by Gordon on 30.01.24.
//

import SwiftUI
import CachedAsyncImage

struct GroupCarouselView: View {
    @EnvironmentObject var viewModel: GroupViewModel
    @Namespace var namespace

    let group: Group
    
    @State var dragOffset: CGSize = CGSize.zero
    @State var dragOffsetPredicted: CGSize = CGSize.zero
    @State var toolbarVisible = true
    @State var loadedImage: Image?
    @State var currentGroupImage: GroupImage?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                    .opacity(1.0 - (abs(dragOffset.height) / geometry.size.height))
                    .ignoresSafeArea(.all)
                
                ScrollViewReader { reader in
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 8) {
                            ForEach(viewModel.images) { image in
                                CachedAsyncImage(url: URL(string: image.urls[FilterType.none.rawValue]!), urlCache: .imageCache) { phase in
                                    switch phase {
                                    case .empty:
                                        ZStack {
                                            Rectangle()
                                                .fill(.gray)
                                                .frame(width: geometry.size.width, height: geometry.size.height)
                                            
                                            ProgressView()
                                        }
                                    case .success(let phaseImage):
                                        phaseImage
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .offset(x: self.dragOffset.width, y: self.dragOffset.height)
                                            .scaleEffect(CGSize(width: 1 - (abs(dragOffset.height) / geometry.size.height), height: 1 - (abs(dragOffset.height) / geometry.size.height)))
                                            .frame(width: geometry.size.width, height: geometry.size.height)
                                            .containerRelativeFrame(.horizontal)
                                            .matchedGeometryEffect(id: image.id, in: namespace)
                                            .id(image.id)
                                            .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
                                                .onChanged { value in
                                                    if value.translation.height != 0 {
                                                        self.dragOffset = value.translation
                                                        self.dragOffsetPredicted = value.predictedEndTranslation
                                                    }
                                                }
                                                .onEnded { value in
                                                    if((abs(self.dragOffset.height) + abs(self.dragOffset.width) > 570) || ((abs(self.dragOffsetPredicted.height)) / (abs(self.dragOffset.height)) > 2) || ((abs(self.dragOffsetPredicted.width)) / (abs(self.dragOffset.width))) > 2) {
                                                        withAnimation(.spring()) {
                                                            self.dragOffset = self.dragOffsetPredicted
                                                        }
                                                        
                                                        withAnimation() {
                                                            viewModel.showCarousel = false
                                                        }
                                                        return
                                                    }
                                                    withAnimation(.interactiveSpring()) {
                                                        self.dragOffset = .zero
                                                        self.dragOffsetPredicted = .zero
                                                    }
                                                }
                                            )
                                            .onTapGesture() {
                                                withAnimation() {
                                                    toolbarVisible.toggle()
                                                }
                                            }
                                            .onAppear() {
                                                loadedImage = phaseImage
                                                currentGroupImage = image
                                            }
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
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                    .onAppear() {
                        if let selectedImage = viewModel.selectedImage {
                            reader.scrollTo(selectedImage.id)
                        }
                    }
                }
                
                if toolbarVisible {
                    VStack {
                        HStack {
                            Button {
                                viewModel.showCarousel = false
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 24))
                            }
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                        
                        Spacer()
                        
                        HStack {
                            if let loadedImage {
                                ShareLink(item: loadedImage, preview: SharePreview("", image: loadedImage)) {
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.system(size: 24))
                                }
                            }
                            
                            Spacer()
                            
                            Button {
                                Task {
                                    if let currentGroupImage {
                                        await viewModel.deleteImage(currentGroupImage, group: group)
                                        if viewModel.images.count == 0 {
                                            withAnimation() {
                                                viewModel.showCarousel = false
                                            }
                                        }
                                    }
                                }
                            } label: {
                                Image(systemName: "trash")
                                    .font(.system(size: 24))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                    }
                    .opacity(1.0 - (abs(dragOffset.height) / geometry.size.height))
                }
            }
        }
        .toolbar(.hidden)
    }
}

#Preview {
    GroupCarouselView(group: Group.Example)
}
