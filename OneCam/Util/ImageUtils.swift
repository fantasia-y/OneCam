//
//  ImageUtils.swift
//  OneCam
//
//  Created by Gordon on 07.02.24.
//

import Foundation
import UIKit
import Amplify

class ImageUtils {
    static func cropImage(_ image: UIImage) -> UIImage {
        let sideLength = min(
            image.size.width,
            image.size.height
        )

        let sourceSize = image.size
        let xOffset = (sourceSize.width - sideLength) / 2.0
        let yOffset = (sourceSize.height - sideLength) / 2.0

        // The cropRect is the rect of the image to keep,
        // in this case centered
        let cropRect = CGRect(
            x: xOffset,
            y: yOffset,
            width: sideLength,
            height: sideLength
        ).integral

        // Center crop the image
        let sourceCGImage = image.cgImage!
        let croppedCGImage = sourceCGImage.cropping(
            to: cropRect
        )!
        
        return UIImage(
            cgImage: croppedCGImage,
            scale: image.imageRendererFormat.scale,
            orientation: image.imageOrientation
        )
    }
    
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
