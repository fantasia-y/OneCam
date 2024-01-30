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
    
    var body: some View {
        if viewModel.showCamera {
            CameraView(showCamera: $viewModel.showCamera) { image in
                HStack {
                    Button("Upload", systemImage: "paperplane.fill") {
                        Task {
                            await viewModel.uploadImage(image, group: group)
                        }
                    }
                    .font(.system(size: 24))
                    .foregroundStyle(.white)
                }
            }
            .navigationBarBackButtonHidden()
        } else {
            GroupGridView(group: group)
                .environmentObject(viewModel)
                .overlay {
                    if viewModel.showCarousel {
                        GroupCarouselView(group: group)
                            .environmentObject(viewModel)
                    }
                }
        }
    }
}

#Preview {
    GroupView(group: Group.Example)
}
