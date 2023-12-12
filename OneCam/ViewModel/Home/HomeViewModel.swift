//
//  HomeViewModel.swift
//  OneCam
//
//  Created by Gordon on 12.12.23.
//

import Foundation
import GordonKirschAPI

class HomeViewModel: ObservableObject {
    @Published var showCreateSession = false
    @Published var showCodeScanner = false
    
    @Published var sessions: [Session] = []
    
    @MainActor
    func getSessions() async {
        let result = await API.shared.get(path: "/session", decode: [Session].self)
        
        if case .success(let data) = result {
            sessions = data
        } else {
            // handle error
        }
    }
}
