//
//  NewsImageViewModel.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 10/05/2024.
//
import Foundation
import SwiftSoup

class NewsImageViewModel: ObservableObject {
    @Published var imageData: Data?
    
    func fetchImage(fromUrl initialURL: String) {
        guard let initialUrl = URL(string: initialURL) else {
            print("Invalid URL")
            return
        }
      
        let extractor = UrlExtractor()
        extractor.extractUrl(fromUrl: initialUrl) { finalUrl in
            if let finalUrl = finalUrl {
                print("Final URL: \(finalUrl)")
                
                self.downloadImage(fromUrl: (extractor.extractImageUrl(fromUrl: finalUrl) ?? URL.init(string: "https://www.mirror.co.uk/news/us-news/people-flabbergasted-after-learning-what-32769946"))!)
            } else {
                print("No URL found")
            }
        }
    }

    private func downloadImage(fromUrl imageUrl: URL) {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)

        let request = URLRequest(url: imageUrl)

        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                self.imageData = data
            }
        }.resume()
    }
}

class UrlExtractor {
    
    
    func extractImageUrl(fromUrl finalUrl: URL) -> URL? {
        
        guard let html = try? String(contentsOf: finalUrl, encoding: .utf8) else { return nil }

        do {
                let doc = try SwiftSoup.parse(html)
                print("doc")
                print(doc)
                let imgElements = try doc.select("img")
                print(imgElements)
                for imgElement in imgElements {
                    if let src =  try? imgElement.attr("src"),  let imageUrl = URL(string: src) {
                        print("imageUrl")
                        print(src)
                        print("\(imageUrl)")
                        return imageUrl
                    }
                }
            } 
        catch 
          
        {
                print("Error parsing HTML: \(error.localizedDescription)")
            }
            return nil
        }
    
    func extractUrl(fromUrl url: URL, completion: @escaping (URL?) -> Void) {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let session = URLSession(configuration: configuration)

        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching initial URL: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            guard let html = String(data: data, encoding: .utf8) else {
                print("Unable to decode HTML content")
                completion(nil)
                return
            }
            
            let regexPattern = #"Opening\s*<a\s*href="([^"]+)""#
            guard let regex = try? NSRegularExpression(pattern: regexPattern, options: []) else {
                print("Invalid regex pattern")
                completion(nil)
                return
            }
            
            let range = NSRange(html.startIndex..., in: html)
            if let match = regex.firstMatch(in: html, options: [], range: range),
               let urlRange = Range(match.range(at: 1), in: html) {
                let extractedUrlString = String(html[urlRange])
                let extractedUrl = URL(string: extractedUrlString)
                completion(extractedUrl)
            } else {
                print("No URL found after 'Opening'")
                completion(nil)
            }
        }.resume()
    }
}

