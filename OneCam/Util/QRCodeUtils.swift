//
//  QRCodeUtils.swift
//  OneCam
//
//  Created by Gordon on 23.11.23.
//

import Foundation
import SwiftUI

class QRCodeUtils {
    static func generate(from string: String) -> UIImage {
        let context = CIContext()
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(Data(string.utf8), forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            
            if let outputImage = filter.outputImage?.transformed(by: transform) {
                if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                    return UIImage(cgImage: cgimg)
                }
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    static func generate(forSession session: String) -> UIImage {
        return generate(from: ApiClient.shared.getBaseUrl() + "/\(session)")
    }
}
