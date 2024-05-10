//
//  NewsImageViewModel.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 10/05/2024.
//

import SwiftUI

struct NewsImageView: View {
    @ObservedObject var newsImageViewModel: NewsImageViewModel
    
    init(imageUrl: String)  {
        newsImageViewModel = NewsImageViewModel()
        newsImageViewModel.fetchImage(fromUrl: imageUrl)
    }
    
    var body: some View {
        if let imageData = newsImageViewModel.imageData, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Text("Loading Image...")
        }
    }
}





