//
//  GroupViewModel.swift
//  OneCam
//
//  Created by Gordon on 25.01.24.
//

import Foundation
import GordonKirschAPI
import UIKit
import Amplify

@MainActor
class GroupViewModel: ObservableObject {
    @Published var localImages: [GroupLocalImage] = []
    @Published var images: [GroupImage] = []
    
    @Published var showShareView = false
    @Published var showSettings = false
    @Published var showCamera = false
    @Published var showCarousel = false
    @Published var selectedImage: GroupImage?
    
    var currentPage = -1
    
    func getImages(_ group: Group) async {
        self.currentPage += 1
        
        let result = await API.shared.get(path: "/group/\(group.uuid)/images", decode: [GroupImage].self, parameters: ["page": currentPage.description])
        
        if case .success(let data) = result {
            self.images += data
        } else {
            // handle error
        }
    }
    
    func getLocalImages(_ group: Group) {
        // self.localImages = GroupLocalImageDataSource.shared.fetch(byGroup: group)
    }
    
    func refreshImage(_ group: Group) async {
        self.currentPage = 0
        
        let result = await API.shared.get(path: "/group/\(group.uuid)/images", decode: [GroupImage].self, parameters: ["page": currentPage.description])
        
        if case .success(let data) = result {
            self.images = data
        } else {
            // handle error
        }
    }
    
    @MainActor
    func uploadImage(_ image: UIImage, group: Group) async {
        // store image locally (swift data)
        // else -> mark as queued
        // if upload fails -> mark as queued
        let localImage = GroupLocalImage(id: UUID(), group: group, image: image.jpegData(compressionQuality: 100)!)
        
        localImages.insert(localImage, at: 0)
        // GroupLocalImageDataSource.shared.append(localImage)
        showCamera = false
        
        if let _ = await ImageUtils.uploadImage(image, key: localImage.key) {
            let result = await API.shared.post(path: "/group/\(group.uuid)/images", decode: GroupImage.self, parameters: ["name": localImage.name])
            if case .success(let data) = result {
                self.replaceLocalImage(localImage, with: data)
            } else {
                // TODO handle error
                print("Upload error")
            }
        } else {
            // TODO handle error
            print("Upload error")
        }
    }
    
    func deleteImage(_ image: GroupImage, group: Group) async {
        images.removeAll(where: { $0.id == image.id })
        
        let _ = await API.shared.delete(path: "/group/\(group.uuid)/images/\(image.id)")
        
        // TODO handle error
    }
    
    private func replaceLocalImage(_ localImage: GroupLocalImage, with image: GroupImage) {
        localImages.removeAll(where: { $0.id == localImage.id })
        images.insert(image, at: 0)
    }
}
