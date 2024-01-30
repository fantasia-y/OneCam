//
//  GroupViewModel.swift
//  OneCam
//
//  Created by Gordon on 25.01.24.
//

import Foundation
import GordonKirschAPI
import UIKit

@MainActor
class GroupViewModel: ObservableObject {
    @Published var localImages: [UIImage] = []
    @Published var images: [GroupImage] = []
    
    @Published var showShareView = false
    @Published var showSettings = false
    @Published var showCamera = false
    
    var currentPage = -1
    
    func getImages(forGroup group: Group) async {
        self.currentPage += 1
        
        let result = await API.shared.get(path: "/group/\(group.groupId.uuidString.lowercased())/images", decode: [GroupImage].self, parameters: ["page": currentPage.description])
        
        if case .success(let data) = result {
            self.images += data
        } else {
            // handle error
        }
    }
    
    func uploadImage(_ image: UIImage) {
        // store image locally
        // if network available -> upload image
        // else -> mark as queued
        // if upload fails -> mark as queued
        // after upload, replace with thumbnail
        
        localImages.insert(image, at: 0)
        showCamera = false
    }
    
    func testReplace() {
        localImages.removeAll()
        images.insert(.init(id: 10, name: "2f1317df-b5fe-4ef1-b62d-bf427d660ca4.jpg"), at: 0)
    }
}
