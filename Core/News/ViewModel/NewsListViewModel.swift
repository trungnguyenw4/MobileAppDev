//
//  NewsListViewModel.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 09/05/2024.
//

import Foundation

class NewsListViewModel: ObservableObject{
    @Published var news = [NewsViewModel]()
    @Published var imageData = [String: Data]()
    
}
