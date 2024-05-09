//
//  NewsCellView.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 09/05/2024.
//

import SwiftUI

struct NewsCellView: View {
    let news: NewsElement
    var newsCellViewModel = NewsCellViewModel()
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Display news title
            Text(news.title)
                .font(.headline)
            
            // Display news author
            Text("By \(news.author)")
                .font(.subheadline)
                .foregroundColor(.gray)
           
            
            Text("Link \(newsCellViewModel.modifyURL( news.link) )")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            // Display news description (if available)
     
            
            // Display news photo (if available)
            // Add your photo display logic here
            
            Divider()
        }
        .padding(8)
        .sheet(isPresented: $isPresented) {
            
            NewsArticleWebView(newsUrl: newsCellViewModel.modifyURL(self.news.link), dismissAction: {
                        self.isPresented = false // Dismiss the sheet
                    })
        }
            .onTapGesture {
                self.isPresented.toggle()
            }
               
    }
}

