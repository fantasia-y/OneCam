//
//  HomeViewModel.swift
//  OneCam
//
//  Created by Gordon on 12.12.23.
//

import Foundation
import GordonKirschAPI
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var path = NavigationPath()
    
    @Published var showCreateGroup = false
    @Published var showCodeScanner = false
    @Published var showProfile = false
    
    @Published var initialLoad = true
    
    @Published var groups: [Group] = []
    
    @MainActor
    func getGroups() async {
        let result = await API.shared.get(path: "/group", decode: [Group].self)
        
        if case .success(let data) = result {
            groups = data
        } else {
            // handle error
        }
        
        if initialLoad { initialLoad.toggle() }
    }
}
