//
//  RootViewModel.swift
//  What'sNews
//
//  Created by Trung Nguyen on 06/05/2024.
//

import Foundation
import Firebase
import Combine

class RootViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    private var cancellable = Set<AnyCancellable>()
    private var authService = AuthService.shared
    
    init() {
       setupSubscribers()
    }
    
     private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellable)
    }
    
    var isAnonymous: Bool {
           userSession?.isAnonymous ?? false
       }
    
}
