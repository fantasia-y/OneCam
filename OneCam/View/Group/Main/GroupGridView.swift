//
//  GroupGridView.swift
//  OneCam
//
//  Created by Gordon on 30.01.24.
//

import SwiftUI
import UIKit

struct GroupGridView: View {
    @EnvironmentObject var viewModel: GroupViewModel
    
    @State var group: Group
    let columns = [GridItem(.flexible(), spacing: 2), GridItem(.flexible(), spacing: 2), GridItem(.flexible(), spacing: 2)]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(viewModel.localImages) { image in
                        GroupLocalImageView(image: image)
                    }
                    
                    ForEach(Array(viewModel.images.enumerated()), id: \.element) { index, image in
                        GroupImageView(image: image, group: group, isEditing: .constant(false))
                            .environmentObject(viewModel)
                            .onAppear() {
                                if viewModel.images.count < group.imageCount, index == viewModel.images.count - 9 {
                                    Task {
                                        await viewModel.getImages(group)
                                    }
                                }
                            }
                    }
                }
            }
            
            Button {
                viewModel.showCamera = true
            } label: {
                Circle()
                    .stroke(.white, lineWidth: 6)
                    .frame(width: 70, height: 70)
                    .shadow(radius: 6)
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
        }
        .navigationTitle(group.name)
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar() {
            if !viewModel.showCarousel {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Button("Select", systemImage: "checkmark.circle") {
                            
                        }
                        
                        Button("Share", systemImage: "square.and.arrow.up") {
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
    }
}

#Preview {
    GroupGridView(group: Group.Example)
}
