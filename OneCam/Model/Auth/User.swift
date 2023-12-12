//
//  User.swift
//  CoLiving
//
//  Created by Gordon on 31.03.23.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: Int
    let email: String?
    let displayname: String?
    let imageUrl: String?
    let emailVerified: Bool?
    let setupDone: Bool?
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
        imageUrl: "2374EA57-8EBD-48C4-BBEB-08779895BBD6.jpeg",
        emailVerified: true,
        setupDone: true
    )
}
