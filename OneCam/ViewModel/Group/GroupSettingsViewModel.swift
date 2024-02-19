//
//  GroupSettingsViewModel.swift
//  OneCam
//
//  Created by Gordon on 24.01.24.
//

import Foundation
import GordonKirschAPI

class GroupSettingsViewModel: ObservableObject {
    @Published var showRemoveDialog = false
    @Published var showDeleteDialog = false
    @Published var showLeaveDialog = false
    
    @Published var selectedUser: User?
    
    @MainActor
    func removeSelectedUserFrom(group: Group) async -> User? {
        if let selectedUser {
            let result = await API.shared.delete(path: "/group/\(group.uuid)/user/\(selectedUser.id)", decode: [Group].self)
            
            if case .success(_) = result {
                let removedUser = selectedUser
                self.selectedUser = nil
                return removedUser
            } else {
                // toast
            }
        }
        
        return nil
    }
}
