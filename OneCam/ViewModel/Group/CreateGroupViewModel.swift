//
//  CreateSessionViewModel.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import Foundation
import SwiftUI
import GordonKirschAPI

class CreateGroupViewModel: ObservableObject {
    @Published var groupName: String = ""
    @Published var group: Group?
    
    @MainActor
    func publish() async {
        let newSession = NewGroup(name: groupName)
        
        let result = await API.shared.post(path: "/group", decode: Group.self, parameters: newSession)
        
        if case .success(let data) = result {
            print(data)
            group = data
        } else {
            // handle error
        }
    }
}
