//
//  GroupSettingsViewModel.swift
//  OneCam
//
//  Created by Gordon on 24.01.24.
//

import Foundation
import GordonKirschAPI

class GroupSettingsViewModel: ObservableObject {
    func leaveGroup(_ group: Group, user: User) async -> Bool {
        let result = await API.shared.delete(path: "/group/\(group.groupId)/user/\(user.id)", decode: [Group].self)
        
        if case .success(_) = result {
            return true
        } else {
            return false
        }
    }
}
