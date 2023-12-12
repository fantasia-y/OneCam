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
