//
//  ImageUtils.swift
//  OneCam
//
//  Created by Gordon on 07.02.24.
//

import Foundation
import UIKit
import Amplify

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
