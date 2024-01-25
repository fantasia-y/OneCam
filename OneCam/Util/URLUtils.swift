//
//  URLUtils.swift
//  OneCam
//
//  Created by Gordon on 23.11.23.
//

import Foundation
import GordonKirschAPI

class URLUtils {
    static func isOwnHost(_ url: URL) -> Bool {
        let own = URL(string: API.shared.getBaseUrl())!
        
        if let ownHost = own.host(), let otherHost = url.host() {
            return ownHost == otherHost
        }
        return false
    }
    
    static func generateShareUrl(forSession session: Group) -> URL {
        var url = URL(string: API.shared.getBaseUrl())!
        url.append(path: "join")
        url.append(path: session.groupId.uuidString.lowercased())

        return url
    }
    
    static func generateUrl(forImage image: GroupImage, andGroup group: Group) -> URL {
        var url = URL(string: API.shared.getBaseUrl())!
        url.append(path: "group")
        url.append(path: group.groupId.uuidString.lowercased())
        url.append(path: "images")
        url.append(path: image.id.description)

        return url
    }
}
