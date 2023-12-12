//
//  Session.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import Foundation

struct Session: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
    var validUntil: Date
    var maxParticipants: Int
    var allowGuests: Bool
    var sessionId: UUID
    var owner: User
    var participants: [User]
}

struct NewSession: Codable {
    var name: String
    var validUntil: Date
    var maxParticipants: Int
    var allowGuests: Bool
}

extension Session {
    static let Example = Session(id: 1, name: "Test Session", validUntil: Date.now, maxParticipants: 10, allowGuests: true, sessionId: UUID(uuidString: "c37ea2a3-631f-4d33-a693-83d543995bb1")!, owner: User.Example, participants: [])
}
