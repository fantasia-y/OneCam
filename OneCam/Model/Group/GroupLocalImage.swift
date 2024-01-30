//
//  GroupLocalImage.swift
//  OneCam
//
//  Created by Gordon on 30.01.24.
//

import Foundation
import UIKit

struct GroupLocalImage: Hashable, Identifiable {
    let id = UUID()
    let group: Group
    let image: UIImage
    
    var name: String {
        get { "\(id.uuidString.lowercased()).jpg" }
    }
    
    var key: String {
        get { "images/\(group.uuid)/\(name)" }
    }
}
