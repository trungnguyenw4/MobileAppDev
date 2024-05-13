//
//  FamousPlacesView.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 12/05/2024.
//

import SwiftUI
import MapKit

struct FamousPlacesNearByView: View {
    @StateObject private var viewModel = FamousPlacesNearByViewModel()
    @State private var isFamousPlacesNearbyPresented = false
    @EnvironmentObject var mapViewModel : LocationViewModel
    
    
    var body: some View {
        VStack {
            Text(mapViewModel.mapLocation)
            
            
//            TextField("Enter a location", text: $viewModel.locationText)
//                .padding()
//                .textFieldStyle(RoundedBorderTextFieldStyle())

//            Button("Submit", action: viewModel.submitButtonAction)
//                .padding()
//                .disabled(!viewModel.isSubmitEnabled)
            
           
            
            
            if let coordinate = viewModel.coordinate {
                PinedMapService(coordinate: coordinate, annotations: viewModel.annotations)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 300)

                HStack {
                    Button("Restaurants", action: { viewModel.searchPlaces(query: "restaurants") })
                        .padding()

                    Button("Tourist Places", action: { viewModel.searchPlaces(query: "tourist attractions") })
                        .padding()
                }
            }
        }
        .padding()
        .onAppear() {
            viewModel.locationText = mapViewModel.mapLocation
            print(viewModel.locationText)
            viewModel.submitButtonAction()
        }
//        .onReceive(viewModel.$locationText) { newText in
//            viewModel.isSubmitEnabled = !newText.isEmpty
//        }
        
    }
}
