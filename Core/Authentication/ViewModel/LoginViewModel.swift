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
    
    
//    func sendCode() {
//        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
//        let number = "+21653615510"
//        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (code,error) in
//            if let error = error {
//                self.errorMsg = error.localizedDescription
//                self.error.toggle()
//                return
//            }
//            self.code = code ?? ""
//            self.goToVerify = true
//             NavigationLink(destination: Verification(oginData: loginData),isActive: $loginData.goToVerify)
//        }
//    }

