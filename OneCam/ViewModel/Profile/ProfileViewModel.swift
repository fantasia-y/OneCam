//
//  ProfileViewModel.swift
//  OneCam
//
//  Created by Gordon on 19.02.24.
//

import Foundation
import UIKit
import GordonKirschAPI

class ProfileViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var newDisplayname: String = ""
    
    @MainActor
    func updateUser() async -> User? {
        let key = "\(UUID().uuidString.lowercased()).jpg"
        var parameters = ["displayname": newDisplayname]
        
        if let image, let _ = await ImageUtils.uploadImage(image, key: "user/\(key)") {
            parameters["imageName"] = key
        }
        
        let result = await API.shared.put(path: "/user", decode: User.self, parameters: parameters)
        switch result {
        case .success(let data):
            return data
        case .serverError(let err), .authError(let err):
            print(err.message)
            break
        case .networkError(let err):
            print(err)
            break
        }
        
        return nil
    }
}
