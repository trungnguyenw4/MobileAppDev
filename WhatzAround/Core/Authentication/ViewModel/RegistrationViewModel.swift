//
//  RegistrationViewModel.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 05/05/2024.
//

import Foundation




class RegistrationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var fullName: String = ""
    @Published var phoneNumber: String = ""
    @Published var showInvalidEmailAlert: Bool = false
    @Published var showInvalidPasswordAlert: Bool = false
    
    private let emailRegexPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
    private let passwordRegexPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%]).{6,24}$"
    
    // Function to validate an email address using regex
    private func isValidEmail(_ email: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegexPattern)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegexPattern)
        return passwordPredicate.evaluate(with: password)
    }
    
    func createUser() async throws {
        if isValidEmail(email) {
            if isValidPassword(password){
                try await AuthService.shared.createUser(withEmail: email, password: password, fullName: fullName, phoneNumber: phoneNumber)
            } else {
                // Show alert if email is not valid
                showInvalidPasswordAlert = true
            }
        }else{
            
            showInvalidEmailAlert = true
        }
    }
}
