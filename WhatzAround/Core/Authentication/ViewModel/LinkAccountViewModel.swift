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
   
    @Published var showInvalidEmailAlert: Bool = false
    @Published var showInvalidPasswordAlert: Bool = false
    
    private let emailRegexPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$"
    private let passwordRegexPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%]).{5,24}$"
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegexPattern)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegexPattern)
        return passwordPredicate.evaluate(with: password)
    }
    
    func linkAccount() async throws {
        if isValidEmail(email) {
            if isValidPassword(password){
                try await AuthService.shared.linkAccount(withEmail: email, password: password)
            } else {
                // Show alert if email is not valid
                showInvalidPasswordAlert = true
            }
        }else{
            
            showInvalidEmailAlert = true
        }
    }
    

    
}
