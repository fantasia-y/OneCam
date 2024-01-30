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
        if viewModel.showCamera {
            CameraView(showCamera: $viewModel.showCamera) { image in
                HStack {
                    Button("Upload", systemImage: "paperplane.fill") {
                        viewModel.uploadImage(image)
                    }
                    .font(.system(size: 24))
                    .foregroundStyle(.white)
                }
            }
            .navigationBarBackButtonHidden()
        } else {
            ZStack(alignment: .bottom) {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(viewModel.localImages, id: \.self) { image in
                            GroupLocalImageView(image: image)
                        }
                        
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
                
                Button {
                    viewModel.showCamera = true
                } label: {
                    Circle()
                        .stroke(.white, lineWidth: 6)
                        .frame(width: 70, height: 70)
                        .shadow(radius: 6)
                }
                .padding()
                
                Button("Test") {
                    viewModel.testReplace()
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
                Task { // TODO on call on first appear
                    if viewModel.currentPage == -1 {
                        await viewModel.getImages(forGroup: group)
                    }
                }
            }
        }
    }
}

#Preview {
    GroupView(group: Group.Example)
}
