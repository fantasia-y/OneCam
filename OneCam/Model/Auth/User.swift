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
        imageUrl: nil,
        emailVerified: true,
        setupDone: true
    )
    
    func getImageUrl(size: CGFloat = 32) -> String {
        if let imageUrl, !imageUrl.isEmpty {
            return imageUrl
        }
        // TODO replace with displayname when onboarding is implemented
        return "https://ui-avatars.com/api/?name=\(email!)&size=128"
    }
}
