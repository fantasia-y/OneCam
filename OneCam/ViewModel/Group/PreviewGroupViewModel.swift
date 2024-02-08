//
//  PreviewSessionViewModel.swift
//  OneCam
//
//  Created by Gordon on 11.12.23.
//

import Foundation
import GordonKirschAPI

class PreviewGroupViewModel: ObservableObject {
    @Published var group: Group?
    
    @MainActor
    func getGroup(_ id: String) async {
        let result = await API.shared.get(path: "/group/\(id)", decode: Group.self)
        
        if case .success(let data) = result {
            group = data
        } else {
            // handle error
        }
    }
    
    func joinGroup(_ group: Group) async -> Bool {
        let result = await API.shared.post(path: "/group/join", parameters: ["id": group.uuid])
        
        if case .success = result {
            return true
        } else {
            return false
            // handle error
        }
    }
    
    func isJoinable(forUser user: User) -> Bool {
        if let session = group {
            return session.owner.id != user.id && !session.participants.contains(where: { participant in
                participant.id == user.id
            })
        }
        
        return false
    }
}
