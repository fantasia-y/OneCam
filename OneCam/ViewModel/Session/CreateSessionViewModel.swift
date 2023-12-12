//
//  CreateSessionViewModel.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import Foundation
import SwiftUI
import GordonKirschAPI

class CreateSessionViewModel: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    @Published var sessionName: String = ""
    @Published var validUntil: Date = Date.now
    @Published var maxParticipants: Int = 10
    @Published var allowGuests: Bool = true
    
    @MainActor
    func publish() async {
        let newSession = NewSession(name: sessionName, validUntil: validUntil, maxParticipants: maxParticipants, allowGuests: allowGuests)
        
        let result = await API.shared.post(path: "/session", decode: Session.self, parameters: newSession)
        
        if case .success(let data) = result {
            print(data)
            navigationPath.append(data)
        } else {
            // handle error
        }
    }
}
