//
//  CreateSessionViewModel.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import Foundation

class CreateSessionViewModel: ObservableObject {
    @Published var sessionName: String = ""
    @Published var validUntil: Date = Date.now
    @Published var maxParticipants: Int = 10
    @Published var allowGuests: Bool = true
    
    func publish() async {
        let newSession = NewSession(name: sessionName, validUntil: validUntil, maxParticipants: maxParticipants, allowGuests: allowGuests)
        
        let result = await ApiClient.shared.post(path: "/session", decode: Session.self, parameters: newSession)
        
        if case .success(let data) = result {
            print(data)
        } else {
            // handle error
        }
    }
}
