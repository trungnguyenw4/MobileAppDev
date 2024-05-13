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
        
        var newsImageView =  NewsImageView(imageUrl: newsCellViewModel.modifyURL( news.link))
        
        VStack(alignment: .leading, spacing: 8) {
            // Display news title
            Text(news.title)
                .font(.headline)
            
            // Display news author
            Text("By \(news.author)")
                .font(.subheadline)
                .foregroundColor(.gray)
           

            // Display news photo
            newsImageView
            
            
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

