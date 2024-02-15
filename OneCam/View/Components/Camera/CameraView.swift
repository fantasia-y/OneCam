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
                Image(uiImage: image)
                    .resizable() // TODO fix scaling
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Button {
                            cameraManager.image = nil
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 24))
                                .foregroundStyle(.white)
                        }
                        .shadow(radius: 6)
                        
                        Spacer()
                    }
                    .padding()
                    
                    Spacer()
                    
                    HStack {
                        content(image)
                            .padding()
                    }
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
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
