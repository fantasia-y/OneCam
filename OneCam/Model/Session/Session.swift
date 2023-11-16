//
//  Session.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import Foundation

struct Session: Codable, Identifiable {
    var id: Int
    var name: String
    var validUntil: Date
    var maxParticipants: Int
    var allowGuests: Bool
}

struct NewSession: Codable {
    var name: String
    var validUntil: Date
    var maxParticipants: Int
    var allowGuests: Bool
}
