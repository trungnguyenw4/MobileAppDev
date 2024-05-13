//
//  JokeView.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 06/05/2024.
//

import SwiftUI



struct JokeView: View {
    
    
    @EnvironmentObject var jokeViewModel: JokeViewModel

    var body: some View {
        VStack(spacing: 10)
        {
            if let  jokeData = jokeViewModel.joke {

                Text(" \(jokeData.joke) ")
                


            } else {
                // You can show a loading indicator or placeholder text here
                Text("Loading...")
            }
            
            
            Button(  action:{  jokeViewModel.loadFileData()}  )
            {
             Text("Get New Joke")
            }
            
        }
        
        
        .padding()
    }
    

    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
