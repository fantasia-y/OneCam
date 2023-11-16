//
//  User.swift
//  CoLiving
//
//  Created by Gordon on 31.03.23.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: String
    let email: String?
    let displayname: String?
    let imageUrl: String?
    let emailVerified: Bool
    let setupDone: Bool
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case emailVerified = "email_verified"
        case setupDone = "setup_done"
        
        case id
        case email
        case displayname
    }
}

struct UpdateUser: Codable {
    var displayname: String
    var imageUrl: String?
}

extension User {
    static let Example = User(
        id: "1edcf4d6-51e4-6602-b6bf-b9b7cfc1c077",
        email: "me@gordonkirsch.dev",
        displayname: "Gordon",
        imageUrl: "2374EA57-8EBD-48C4-BBEB-08779895BBD6.jpeg",
        emailVerified: true,
        setupDone: true
    )
}
