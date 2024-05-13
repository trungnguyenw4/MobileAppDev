//
//  LinkAccountViewModel.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 06/05/2024.
//

import Foundation

class LinkAccountViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMsg = ""
    @Published var error = false
    @Published var code = ""
    @Published var goToVerify = false
    
    func linkAccount() async throws {
        try await AuthService.shared.linkAccount(withEmail: email, password: password)
    }
    
}
