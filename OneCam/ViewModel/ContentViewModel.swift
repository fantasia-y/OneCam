//
//  ContentViewModel.swift
//  OneCam
//
//  Created by Gordon on 16.11.23.
//

import Foundation
import GordonKirschAPI

enum OnboardingState {
    case emailVerification
    case accountSetup
    case finished
}

class ContentViewModel: ObservableObject {
    @Published var onboardingState: OnboardingState = .finished
    @Published var isLoaded = false
    @Published var failedLoading = false
    @Published var userData = UserData()
    
    @MainActor
    func loadUser() async {
        self.failedLoading = false
        
        let result = await API.shared.get(path: "/user", decode: User.self)
        
        switch result {
        case .success(let user):
            self.onUserLoaded(user)
            self.isLoaded = true
            break
        case .networkError(_):
            self.failedLoading = true
        default:
            self.failedLoading = true
        }
    }
        
    func onUserLoaded(_ user: User) {
        userData.currentUser = user
        
        self.onboardingState = .finished
        if !user.emailVerified! {
            self.onboardingState = .emailVerification
        } else if !user.setupDone! {
            self.onboardingState = .accountSetup
        }
    }
}
