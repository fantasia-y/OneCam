//
//  Extensions.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import Foundation
import JWTDecode

extension HTTPURLResponse {
    func isSuccessful() -> Bool {
        return statusCode >= 200 && statusCode <= 299
    }
}

extension JWT {
    var uuid: UUID {
        return UUID(uuidString: self["uuid"].string!)!
    }
    
    var email: String {
        return self["username"].string!
    }
}

extension URL {
    func extractParams() -> [(name: String, value: String)] {
      let components =
        self.absoluteString
        .split(separator: "&")
        .map { $0.split(separator: "=") }

      return
        components
        .compactMap {
          $0.count == 2
            ? (name: String($0[0]), value: String($0[1]))
            : nil
        }
    }
}
