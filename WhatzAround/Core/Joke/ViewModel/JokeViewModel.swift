//
//  JokeViewModel.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 06/05/2024.
//

import Foundation
class JokeViewModel: ObservableObject {
    
    @Published var joke: Joke?

    init() {
            Task {
                 loadFileData()
            }
        }

    func loadFileData()  {
        
        if let url = URL(string: "https://v2.jokeapi.dev/joke/Any?type=single"),
           
            let jokeData = try? Data(contentsOf: url) {
            
            
            do {
                let decodedJoke = try JSONDecoder().decode(Joke.self, from: jokeData)
                self.joke = decodedJoke // Set the class property

            }
            catch {
                print("Error decoding JSON: \(error)")
            }
        } 
    }
}
