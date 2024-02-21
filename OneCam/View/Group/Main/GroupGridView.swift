//
//  GroupGridView.swift
//  OneCam
//
//  Created by Gordon on 30.01.24.
//

import SwiftUI
import UIKit

class Rectangles {
    var content = [Int : CGRect]()
}

struct GroupGridView: View {
    @EnvironmentObject var viewModel: GroupViewModel
    
    var rectangles = Rectangles()
    @State var selectRect: CGRect?
    
    
    @State var group: Group
    let columns = [GridItem(.flexible(), spacing: 2), GridItem(.flexible(), spacing: 2), GridItem(.flexible(), spacing: 2)]
    
    private var dragSelect: some Gesture {
        DragGesture(minimumDistance: 2)
            .onChanged() { drag in
                let a = drag.startLocation
                let b = drag.location

                selectRect = CGRect(x: min(a.x, b.x), y: min(a.y, b.y), width: abs(a.x - b.x), height: abs(a.y - b.y))

                var resSet: [Int] = []

                for i in 0 ..< viewModel.images.count {
                    if CGRectIntersectsRect(rectangles.content[i]!, selectRect!) {
                        resSet.append(i)
                    }
                }
                
                if !resSet.isEmpty {
                    viewModel.selectedSubviews = Set(resSet.first!...resSet.last!)
                } else {
                    viewModel.selectedSubviews = Set<Int>()
                }
            }
            .onEnded() { _ in
                selectRect = nil
            }
    }
    
    private func isSelected(_ index: Int) -> Bool {
        return viewModel.selectedSubviews.contains(index)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(viewModel.localImages) { image in
                        GroupLocalImageView(image: image)
                    }
                    
                    ForEach(Array(viewModel.images.enumerated()), id: \.element) { index, image in
                        GroupImageView(image: image, group: group, isEditing: viewModel.isEditing, isSelected: isSelected(index))
                            .environmentObject(viewModel)
                            .onAppear() {
                                if viewModel.images.count < group.imageCount, index == viewModel.images.count - 9 {
                                    Task {
                                        await viewModel.getImages(group)
                                    }
                                }
                            }
                            .background() {
                                GeometryReader { gp -> Color in
                                    rectangles.content[index] = gp.frame(in: .named("container"))
                                    return Color.clear
                                }
                            }
                            .gesture(
                                TapGesture()
                                    .onEnded {
                                        if viewModel.selectedSubviews.contains(index) {
                                            viewModel.selectedSubviews.remove(index)
                                        } else {
                                            viewModel.selectedSubviews.insert(index)
                                        }
                                    }
                            )
                    }
                }
                .coordinateSpace(name: "container")
                .if(viewModel.isEditing) { view in
                    view.gesture(dragSelect)
                }
            }
            
            if !viewModel.isEditing {
                Button {
                    viewModel.showCamera = true
                } label: {
                    Circle()
                        .stroke(.white, lineWidth: 6)
                        .frame(width: 70, height: 70)
                        .shadow(radius: 6)
                }
            }
            
            if viewModel.showCarousel {
                GroupCarouselView(group: group)
                    .environmentObject(viewModel)
                    .transition(
                        .asymmetric(
                            insertion: .opacity.animation(.easeIn),
                            removal: .opacity.animation(.easeOut)
                        )
                    )
            }
            
            if viewModel.showDownloadedImages {
                ActivityViewController(images: $viewModel.downloadedImages, showing: $viewModel.showDownloadedImages)
            }
        }
        .navigationTitle(group.name)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar() {
            if !viewModel.showCarousel, !viewModel.isEditing {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button("Select", systemImage: "checkmark.circle") {
                            viewModel.isEditing = true
                        }
                        
                        ShareLink(item: URLUtils.generateShareUrl(forGroup: group))

                        Button("Share QR Code...", systemImage: "qrcode") {
                            viewModel.showShareView = true
                        }
                        
                        Button("Settings", systemImage: "gear") {
                            viewModel.showSettings = true
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
            
            if viewModel.isEditing {
                ToolbarItem(placement: .primaryAction) {
                    HStack {
                        
                        
                        Button("Cancel") {
                            viewModel.isEditing = false
                            viewModel.selectedSubviews = Set<Int>()
                        }
                    }
                }
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        Task {
                            await viewModel.saveSelectedImages()
                        }
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    
                    Spacer()
                    
                    Button {
                        Task {
                            // await viewModel.saveSelectedImages()
                        }
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.showSettings) {
            GroupSettingsView(group: $group)
        }
        .sheet(isPresented: $viewModel.showShareView) {
            ShareGroupView(group: group)
        }
        .refreshable() {
            Task {
                await viewModel.refreshImage(group)
            }
        }
        .onAppear() {
            Task {
                if viewModel.currentPage == -1 {
                    await viewModel.getImages(group)
                    // viewModel.getLocalImages(group)
                }
            }
        }
        .overlay {
            if viewModel.isSaving {
                ZStack {
                    Color.black
                        .opacity(0.4)
                        .ignoresSafeArea()
                    
                    Card {
                        VStack(spacing: 20) {
                            ProgressView(value: viewModel.saveProgress, total: 1)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 50, height: 50)
                            
                            Text("Loading...")
                                .foregroundStyle(Color("textSecondary"))
                        }
                        .padding(.all, 20)
                    }
                }
            }
        }
        .toastView(toast: $viewModel.toast)
    }
}

#Preview {
    GroupGridView(group: Group.Example)
        .environmentObject(GroupViewModel())
}
