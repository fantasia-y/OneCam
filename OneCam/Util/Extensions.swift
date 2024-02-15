//
//  Extensions.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import Foundation
import JWTDecode
import UIKit
import SwiftUI

extension JWT {
    var uuid: UUID {
        return UUID(uuidString: self["uuid"].string!)!
    }
    
    var email: String {
        return self["username"].string!
    }
}

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
