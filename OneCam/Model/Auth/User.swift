//
//  User.swift
//  CoLiving
//
//  Created by Gordon on 31.03.23.
//

import Foundation

struct User: Codable, Identifiable, Hashable, ImageStorage {
    let id: Int
    let email: String?
    let displayname: String?
    let emailVerified: Bool?
    let setupDone: Bool?
    var urls: [String : String]
}

struct UpdateUser: Codable {
    var displayname: String
    var imageUrl: String?
}

extension User {
    static let Example = User(
        id: 1,
        email: "me@gordonkirsch.dev",
        displayname: "Gordon",
        emailVerified: true,
        setupDone: true,
        urls: [:]
    )
}
