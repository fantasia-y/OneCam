//
//  ImageUtils.swift
//  OneCam
//
//  Created by Gordon on 07.02.24.
//

import Foundation
import UIKit
import Amplify
import SwiftUI

enum CropOrientation {
    case portrait
    case landscape
}

class ImageUtils {
    @MainActor
    static func uploadImage(_ image: UIImage, key: String) async -> String? {
        if let data = image.jpegData(compressionQuality: 90) {
            do {
                let task = Amplify.Storage.uploadData(key: key, data: data, options: .init(contentType: "image/jpeg"))
                let _ = try await task.value

                return key
            } catch {
                print(error)
            }
        }
        return nil
    }
}

extension Image {
    func groupPreview(width: CGFloat, size: GroupPreviewType = .large) -> some View {
        self
            .resizable()
            .scaledToFill()
            .if(size == .large) { view in
                view.frame(width: width, height: width * 1.25)
            }
            .if(size == .list) { view in
                view.frame(height: 180)
            }
            .contentShape(Rectangle())
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
