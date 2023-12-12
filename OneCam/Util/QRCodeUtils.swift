//
//  QRCodeUtils.swift
//  OneCam
//
//  Created by Gordon on 23.11.23.
//

import Foundation
import SwiftUI
import GordonKirschAPI
import GordonKirschUtils

extension QRCodeUtils {
    static func generate(forSession session: Session) -> UIImage {
        return generate(from: URLUtils.generateShareUrl(forSession: session).absoluteString)
    }
}
