//
//  GroupGridView.swift
//  OneCam
//
//  Created by Gordon on 30.01.24.
//

import SwiftUI

struct GroupGridView: View {
    @EnvironmentObject var viewModel: GroupViewModel
    
    let group: Group
    let columns = [GridItem(.flexible(), spacing: 2), GridItem(.flexible(), spacing: 2), GridItem(.flexible(), spacing: 2)]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 2) {
                    ForEach(viewModel.localImages) { image in
                        GroupLocalImageView(image: image)
                    }
                    
                    ForEach(Array(viewModel.images.enumerated()), id: \.element) { index, image in
                        GroupImageView(image: image, group: group)
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
            .padding()
        }
        .navigationTitle(group.name)
        
        .toolbar() {
            Button {
                viewModel.showShareView = true
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
            
            Button {
                viewModel.showSettings = true
            } label: {
                Image(systemName: "gearshape")
            }
        }
        .sheet(isPresented: $viewModel.showSettings) {
            GroupSettingsView(group: group, showSettings: $viewModel.showSettings)
        }
        .sheet(isPresented: $viewModel.showShareView) {
            ShareGroupView(session: group)
        }
        .refreshable() {
            Task {
                await viewModel.refreshImage(group)
            }
        }
        .onAppear() {
            Task { // TODO on call on first appear
                if viewModel.currentPage == -1 {
                    await viewModel.getImages(group)
                }
            }
        }
    }
}

#Preview {
    GroupGridView(group: Group.Example)
}
