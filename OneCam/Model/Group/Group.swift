//
//  Session.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import Foundation

struct Group: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
    var groupId: UUID
    var owner: User
    var participants: [User]
    var imageCount: Int
}

struct NewGroup: Codable {
    var name: String
}

extension Group {
    static let Example = Group(id: 1, name: "Test Session", groupId: UUID(uuidString: "c37ea2a3-631f-4d33-a693-83d543995bb1")!, owner: User.Example, participants: [], imageCount: 10)
    
    func isOwner(_ user: User) -> Bool {
        return owner.id == user.id
    }
}
