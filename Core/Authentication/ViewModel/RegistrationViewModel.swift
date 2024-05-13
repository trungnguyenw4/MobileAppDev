//
//  RegistrationViewModel.swift
//  What'sNews
//
//  Created by Trung Nguyen on 05/05/2024.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fullName: String = ""
    @Published var phoneNumber: String = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: email, password: password, fullName: fullName, phoneNumber: phoneNumber)
    }
}
