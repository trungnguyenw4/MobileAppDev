//
//  User.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 05/05/2024.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable,Identifiable,Hashable {
    
    @DocumentID var uid: String?
    var id: String {
        return uid ?? UUID().uuidString
    }

    
    let fullName: String
    let email: String
    let phoneNumber: String
    let location : String
    var profileImageUrl: String?
    var firstName: String {
        let formatter = PersonNameComponentsFormatter()
        let components = formatter.personNameComponents(from: fullName)
        return components?.givenName ?? fullName
    }
}

