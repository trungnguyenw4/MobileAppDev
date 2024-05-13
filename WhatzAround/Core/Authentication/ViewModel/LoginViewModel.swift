//
//  LoginViewModel.swift
//  What'sNews
//
//  Created by Trung Nguyen on 05/05/2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMsg = ""
    @Published var error = false
    @Published var code = ""
    @Published var goToVerify = false
    
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
    
    func logInAnonymously() async throws {
        try await AuthService.shared.loginAnonymously()
                }
        
        }
    
    

