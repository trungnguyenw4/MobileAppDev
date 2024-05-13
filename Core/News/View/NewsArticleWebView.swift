//
//  NewsArticleWebView.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 09/05/2024.
//

import SwiftUI

struct NewsArticleWebView: View {
    var newsUrl: String
    var dismissAction: () -> Void // Closure to handle dismissal
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Dismiss") {
                    dismissAction() // Call the dismiss action
                }
                .padding()
            }
            .background(Color(.systemBackground))
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            NewsWebView(urlString: newsUrl)
                
                       
        }
        .edgesIgnoringSafeArea(.top)
    }
}


