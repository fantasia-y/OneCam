//
//  GroupImage.swift
//  OneCam
//
//  Created by Gordon on 25.01.24.
//

import Foundation

struct GroupImage: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
}

extension GroupImage {
    static let Example = GroupImage(id: 1, name: "test.jpg")
}
