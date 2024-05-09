//
//  NewsCellViewModel.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 09/05/2024.
//

import Foundation

class NewsCellViewModel:  ObservableObject {
    
    func modifyURL(_ url: String) -> String {
        guard var components = URLComponents(string: url) else {
            return url
        }
        
        // Replace the dot before '/articles/' with an empty string
        components.host = components.host?.replacingOccurrences(of: "news.google.com.", with: "news.google.com")
        
        if let modifiedURL = components.url?.absoluteString {
            return modifiedURL
        } else {
            return url
        }
        
    }
}
