//
//  SettingsViewModel.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 06/05/2024.
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }
        .store(in: &cancellables)
    }
    
    @MainActor
    func logout() {
        AuthService.shared.logout()
    }
    
}
