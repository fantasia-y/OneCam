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

struct ImageWrapper: Identifiable {
    let id = UUID()
    let image: UIImage
}

@MainActor
class GroupViewModel: NSObject, ObservableObject {
    @Published var localImages: [GroupLocalImage] = []
    @Published var images: [GroupImage] = []
    
    @Published var isEditing = false
    @Published var isSaving = false
    @Published var selectedSubviews = Set<Int>()
    @Published var dragSelectedSubviews = Set<Int>()
    @Published var saveProgress = 0.0
    @Published var downloadedImages: [UIImage] = []
    @Published var showDownloadedImages = false
    
    @Published var showShareView = false
    @Published var showSettings = false
    @Published var showCamera = false
    @Published var showCarousel = false
    @Published var selectedImage: GroupImage?
    
    @Published var toast: Toast?
    
    var currentPage = -1
    
    func getImages(_ group: Group) async {
        self.currentPage += 1
        
        let result = await API.shared.get(path: "/group/\(group.uuid)/images", decode: [GroupImage].self, parameters: ["page": currentPage.description])
        
        if case .success(let data) = result {
            self.images += data
        } else {
            toast = Toast.from(response: result)
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
            toast = Toast.from(response: result)
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
                toast = Toast.from(response: result)
            }
        } else {
            toast = Toast.ServerError
        }
    }
    
    func deleteImage(_ image: GroupImage, group: Group) async {
        images.removeAll(where: { $0.id == image.id })
        
        let result = await API.shared.delete(path: "/group/\(group.uuid)/images/\(image.id)")
        
        if case .success(_) = result {
            return
        } else {
            toast = Toast.from(response: result)
        }
    }
    
    private func replaceLocalImage(_ localImage: GroupLocalImage, with image: GroupImage) {
        localImages.removeAll(where: { $0.id == localImage.id })
        images.insert(image, at: 0)
    }
    
    func saveSelectedImages() async {
        // prep ui
        downloadedImages = []
        isEditing = false
        isSaving = true
        
        for index in selectedSubviews {
            let selectedImage = self.images[index]
            let url = selectedImage.urls[FilterType.none.rawValue]!
            
            saveProgress = Double(downloadedImages.count + 1) / Double(selectedSubviews.count)
            print("Downloading image: \(selectedImage.imageName!)")
            
            if let (data, _) = try? await URLSession.shared.data(from: URL(string: url)!) {
                downloadedImages.append(UIImage(data: data)!)
            }
        }
        
        // clean up
        isSaving = false
        saveProgress = 0.0
        selectedSubviews = Set<Int>()
        showDownloadedImages = true
    }
}
