//
//  NewsViewModel.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 08/05/2024.
//

import Foundation

extension DateFormatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
}

class NewsViewModel: ObservableObject {
    @Published var news: [NewsElement] = []
    //@Published var news: NewsElement?
    @Published var location: String = ""
    
    init() {
        Task {
            do {
                print(location)
                try await loadNewsData(for: location) // Load initial data for a default location
            } catch {
                print("Error loading initial data: \(error)")
            }
        }
    }
    
    
    
    func loadNewsData(for location: String) async throws {
        guard let encodedLocation = location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://latest-news-api1.p.rapidapi.com/news/\(encodedLocation)") else {
            print("Invalid URL or location")
            return
        }
        
        let headers = [
            "x-rapidapi-host": "latest-news-api1.p.rapidapi.com",
            "x-rapidapi-key": "73bd6130bdmsh72769164ac674ebp1e76afjsn5b0e0e4388ee"
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            
            // Try parsing the date using ISO8601 format
            if let date = DateFormatter.iso8601.date(from: dateString) {
                return date
            }
            
            // If ISO8601 parsing fails, try parsing with other formats as needed
            // Add more date formats if required
            
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(dateString)")
        }

        do {
                    let decodedNewsList = try decoder.decode([NewsElement].self, from: data) // Decode into an array of NewsElement
                    DispatchQueue.main.async {
                        self.news = decodedNewsList // Assign the decoded list to the news property
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
    }
    
    
    

  

    
    
   
    
    
}
