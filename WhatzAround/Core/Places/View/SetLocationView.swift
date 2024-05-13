//
//  PlacesView.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 07/05/2024.
//

import Firebase
import SwiftUI
import MapKit

struct SetLocationView:  View {
    

    
    @EnvironmentObject var mapViewModel : LocationViewModel
        
        @State var mapLocation = ""
        
        @State var isLoading = false
        
        var body: some View {
            ZStack {
                
                VStack(spacing:20) {
                   
                    Text("Current Location: ")
                    
                    HStack {
                        
                        TextField("", text: $mapViewModel.mapLocation)
                            .padding()
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 3)
                        
                    }
                    
                    .frame(width: 300, height: 50)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 3)
                    .cornerRadius(2.0)
                    
                    Button(action: {
                        isLoading = true
                        Task {
                            do {
                                try await mapViewModel.getCoordinates()
                 
                                //try await mapViewModel.setAnnotations()
                                
                            } catch {
                                // Handle the error if geocoding fails.
                                print("Error: \(error)")
                            }
                            isLoading = false // Question: What is the purpose of this?
                            //mapViewModel.mapLocation = "" // Question: What does this do?
                        }
                        
                        mapLocation = mapViewModel.mapLocation // Question: Explain how this is being used?
                        
                    }) {
                        
                        
                        Text("Set Location")
                            .font(.headline)
                            .padding()
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    .padding()
                    
                    
                }
                
            }

            
        }
    }

