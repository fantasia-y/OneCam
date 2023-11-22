//
//  URLUtils.swift
//  OneCam
//
//  Created by Gordon on 23.11.23.
//

import Foundation

class URLUtils {
    static func isOwnHost(_ url: URL) -> Bool {
        let own = URL(string: ApiClient.shared.getBaseUrl())!
        
        if let ownHost = own.host(), let otherHost = url.host() {
            return ownHost == otherHost
        }
        return false
    }
}
