//
//  GroupViewModel.swift
//  OneCam
//
//  Created by Gordon on 25.01.24.
//

import Foundation
import GordonKirschAPI

@MainActor
class GroupViewModel: ObservableObject {
    @Published var images: [GroupImage] = []
    
    @Published var showShareView = false
    @Published var showSettings = false
    
    private var currentPage = -1
    
    func getImages(forGroup group: Group) async {
        self.currentPage += 1
        
        let result = await API.shared.get(path: "/group/\(group.groupId.uuidString.lowercased())/images", decode: [GroupImage].self, parameters: ["page": currentPage.description])
        
        if case .success(let data) = result {
            self.images += data
        } else {
            // handle error
        }
    }
}
