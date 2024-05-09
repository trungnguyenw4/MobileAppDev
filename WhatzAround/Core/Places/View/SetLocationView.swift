//
//  PlacesView.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 07/05/2024.
//

import SwiftUI
import MapKit

struct SetLocationView:  View {
    
    //@StateObject var mapViewModel = LocationViewModel()
    
    @EnvironmentObject var mapViewModel : LocationViewModel
        
        @State var mapLocation = ""
        
        @State var isLoading = false
        
        var body: some View {
            ZStack {
                
                VStack(spacing:20) {
                   
                    
                    HStack {
                        
                        TextField("Enter the Location", text: $mapViewModel.mapLocation)
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
                 
                                try await mapViewModel.setAnnotations()
                                
                            } catch {
                                // Handle the error if geocoding fails.
                                print("Error: \(error)")
                            }
                            isLoading = false // Question: What is the purpose of this?
                            //mapViewModel.mapLocation = "" // Question: What does this do?
                        }
                        
                        mapLocation = mapViewModel.mapLocation // Question: Explain how this is being used?
                        
                    }) {
                        Text("Show Map")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    VStack(spacing:5){
                        // Question:    What happens if there are no coordinates?
                        if mapViewModel.coordinates != nil {
                            // Question:   What location is shown on the map and how is that achieved?
                            Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true, userTrackingMode: .none, annotationItems: mapViewModel.annotations) {
                                
                                place in
                                MapAnnotation(coordinate: place.location) {
                                    VStack {
                                        Image(systemName: "mappin.circle.fill")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.green) //
                                        Text(place.name)
                                            .font(.footnote)
                                        Text(place.name)
                                            .font(.caption)
                                    }
                                }
                            }
                      
                            
                            .cornerRadius(10)
                            
      
                            
                        }
                    }
                    .frame(height:300)
                    .padding()
                    
                    
                }
                
            }

            
        }
    }

