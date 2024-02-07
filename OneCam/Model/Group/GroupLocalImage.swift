//
//  GroupLocalImage.swift
//  OneCam
//
//  Created by Gordon on 30.01.24.
//

import Foundation
import UIKit
import SwiftData

struct GroupLocalImage: Hashable, Identifiable {
    let id: UUID
    let group: Group
    let image: Data
    
    init(id: UUID, group: Group, image: Data) {
        self.id = id
        self.group = group
        self.image = image
    }
    
    var name: String {
        get { "\(id.uuidString.lowercased()).jpg" }
    }
    
    var key: String {
        get { "images/\(group.uuid)/\(name)" }
    }
}

//final class GroupLocalImageDataSource {
//    private let modelContainer: ModelContainer
//    private let modelContext: ModelContext
//
//    @MainActor
//    static let shared = GroupLocalImageDataSource()
//
//    @MainActor
//    private init() {
//        self.modelContainer = try! ModelContainer(for: GroupLocalImage.self)
//        self.modelContext = modelContainer.mainContext
//    }
//
//    func append(_ item: GroupLocalImage) {
//        modelContext.insert(item)
//        do {
//            try modelContext.save()
//        } catch {
//            fatalError(error.localizedDescription)
//        }
//    }
//
//    func fetch(byGroup group: Group) -> [GroupLocalImage] {
//        do {
//            return try modelContext.fetch(FetchDescriptor<GroupLocalImage>())
//        } catch {
//            fatalError(error.localizedDescription)
//        }
//    }
//
//    func remove(_ item: GroupLocalImage) {
//        modelContext.delete(item)
//    }
//}
