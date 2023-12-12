//
//  PreviewSessionViewModel.swift
//  OneCam
//
//  Created by Gordon on 11.12.23.
//

import Foundation
import GordonKirschAPI

class PreviewSessionViewModel: ObservableObject {
    @Published var session: Session?
    
    @MainActor
    func getSession(_ id: String) async {
        let result = await API.shared.get(path: "/session/\(id)", decode: Session.self)
        
        if case .success(let data) = result {
            session = data
        } else {
            // handle error
        }
    }
    
    func joinSession(_ session: Session) async -> Bool {
        let result = await API.shared.post(path: "/session/join", parameters: ["id": session.sessionId])
        
        if case .success = result {
            return true
        } else {
            return false
            // handle error
        }
    }
    
    func isJoinable(forUser user: User) -> Bool {
        if let session = session {
            return session.owner.id != user.id && !session.participants.contains(where: { participant in
                participant.id == user.id
            })
        }
        
        return false
    }
}
