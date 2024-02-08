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
    
    var uuid: String {
        get { groupId.uuidString.lowercased() }
    }
}

struct NewGroup: Codable {
    var name: String
}

extension Group {
    static let Example = Group(id: 1, name: "Test Session", groupId: UUID(uuidString: "df46e7ba-140d-4721-8b9e-a359dce5e78a")!, owner: User.Example, participants: [], imageCount: 10)
    
    func isOwner(_ user: User) -> Bool {
        return owner.id == user.id
    }
}
