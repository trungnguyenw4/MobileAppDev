//
//  UserService.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 05/05/2024.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

class UserService {
    
    @Published var currentUser: User?
    
    static let shared = UserService()
    
    init() {
            Task { try await fetchCurrentUser() }
        }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    
}
