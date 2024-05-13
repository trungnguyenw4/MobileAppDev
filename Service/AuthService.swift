//
//  AuthService.swift
//  What'sNews
//
//  Created by Trung Nguyen on 05/05/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage


class AuthService: ObservableObject  {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var isAnonymous: Bool = false // New property
    
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.isAnonymous = userSession?.isAnonymous ?? false
        loadCurrentUserData()
    }
    
    @MainActor
    func login(withEmail email: String,password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            loadCurrentUserData()
        } catch {
            print("failed to login with error \(error.localizedDescription)")
        }
    }
    
    
    
    @MainActor
    func createUser(withEmail email: String,password: String,fullName: String, phoneNumber: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            try await  self.uploadUserData(email: email, fullname: fullName, phoneNumber: phoneNumber, id: result.user.uid)
            loadCurrentUserData()
        } catch {
            print("failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func loginAnonymously() async throws {
        do {
            let result = try await Auth.auth().signInAnonymously()
            self.userSession = result.user
 
        } catch {
            print("Failed to login anonymously: \(error.localizedDescription)")
            
        }
    }
    
//    func loginAnonymously()  {
//            Auth.auth().signInAnonymously { result, error in
//                if let error = error {
//                    print("Failed to login anonymously: \(error.localizedDescription)")
//                } else if let user = result?.user {
//                    self.userSession = user
//                    // Optionally, you can load user data or perform any necessary tasks after anonymous login.
//                    // For example:
//                    // self.loadCurrentUserData()
//                }
//            }
//        }
    
    
//    func linkEmail(withEmail email: String,password: String) async throws
//    {
//        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
//        
//        guard let user = Auth.auth().currentUser else
//        {
//            throw URLError(.badURL)
//        }
//            
//        let authDataResult = try await user.link(with: credential)
//       
//    }
    
    func linkAccount(withEmail email: String,password: String) async throws {
        do {
            
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            let result = try await Auth.auth().currentUser?.link(with: credential)
            self.userSession = result?.user
            loadCurrentUserData()
        } catch {
            print("failed to login with error \(error.localizedDescription)")
        }
    }
    
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            UserService.shared.currentUser = nil
        } catch {
            print("failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    private func uploadUserData(email: String, fullname: String,phoneNumber: String,id: String) async throws {
        let user = User(fullName: fullname, email: email, phoneNumber: phoneNumber)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await Firestore.firestore().collection("users").document(id).setData(encodedUser)
    }
    
    private func loadCurrentUserData() {
        Task { try await UserService.shared.fetchCurrentUser()}
    }
    
}
