//
//  CameraView.swift
//  OneCam
//
//  Created by Gordon on 29.01.24.
//

import SwiftUI
import AVFoundation

struct CameraView<Content: View>: View {
    @StateObject var cameraManager = CameraManager()
    
    var showCamera: Binding<Bool>
    let content: (_ image: UIImage) -> Content
    
    init(showCamera: Binding<Bool>, @ViewBuilder contentBuilder: @escaping (_ image: UIImage) -> Content) {
        self.showCamera = showCamera
        self.content = contentBuilder
    }
    
    var body: some View {
        // TODO image preview
        if let image = cameraManager.image {
            ZStack {
                Color.black.ignoresSafeArea(.all)
                
                VStack {
                    HStack {
                        Button {
                            cameraManager.image = nil
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 24))
                                .foregroundStyle(.white)
                        }
                        .padding(.vertical)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                        
                        Image(uiImage: image)
                            .resizable()
                            .clipShape(.rect(cornerRadius: 8))
                            .padding(.all, 3)
                    }
                    .padding()
                    
                    content(image)
                    .frame(minHeight: 80)
                }
            }
        } else {
            CameraViewFinder(showCamera: showCamera)
                .environmentObject(cameraManager)
        }
    }
}

#Preview {
    CameraView(showCamera: .constant(false)) { image in
        HStack {
            Button("Upload", systemImage: "paperplane.fill") {
                
            }
        }
    }
}
