//
//  SwiftUIView.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 07/05/2024.
//
import SwiftUI



struct NewsView: View {
   
    @EnvironmentObject var locationInfo: LocationViewModel
    
    @EnvironmentObject var newsViewModel: NewsViewModel
    
    var body: some View {
        
        VStack {
            if !newsViewModel.news.isEmpty {
                List(newsViewModel.news, id: \.self) { newsItem in
                    NewsCellView(news: newsItem)
                }
            } else {
                ProgressView("Loading...")
            }
        }
        .task
            // Load news data for the location obtained from locationInfo.mapLocation
         {
                do {
                    let location = locationInfo.mapLocation
                    print(location)
                    try await newsViewModel.loadNewsData(for: location)
                } catch {
                    print("Error loading news data: \(error)")
                }
            }
        }

    }





