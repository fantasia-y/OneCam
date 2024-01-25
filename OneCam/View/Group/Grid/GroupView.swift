//
//  SessionView.swift
//  OneCam
//
//  Created by Gordon on 12.12.23.
//

import SwiftUI
import CachedAsyncImage

struct GroupView: View {
    @StateObject var viewModel = GroupViewModel()
    
    let group: Group
    let columns = [GridItem(.flexible(), spacing: 2), GridItem(.flexible(), spacing: 2), GridItem(.flexible(), spacing: 2)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(Array(viewModel.images.enumerated()), id: \.element) { index, image in
                    GroupImageView(image: image, group: group)
                        .onAppear() {
                            if viewModel.images.count < group.imageCount, index == viewModel.images.count - 9 {
                                Task {
                                    await viewModel.getImages(forGroup: group)
                                }
                            }
                        }
                }
            }
        }
        .navigationTitle(group.name)
        .sheet(isPresented: $viewModel.showSettings) {
            GroupSettingsView(group: group, showSettings: $viewModel.showSettings)
        }
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
        .sheet(isPresented: $viewModel.showShareView) {
            ShareGroupView(session: group)
        }
        .onAppear() {
            Task {
                await viewModel.getImages(forGroup: group)
            }
        }
    }
}

#Preview {
    GroupView(group: Group.Example)
}
