//
//  Extensions.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import Foundation
import JWTDecode

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
