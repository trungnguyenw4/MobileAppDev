//
//  Constants.swift
//  What'sNews
//
//  Created by Trung Nguyen on 05/05/2024.
//

import Foundation
import Firebase

struct FirestoreConstants {
    
    static let userCollection = Firestore.firestore().collection("users")
    static let messageCollection = Firestore.firestore().collection("messages")
    
}
