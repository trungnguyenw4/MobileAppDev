//
//  GetCurrentLocationView.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 07/05/2024.
//

import SwiftUI
import MapKit

struct GetCurrentLocationView: View {

    @ObservedObject var mapViewModel = LocationViewModel()
    
    var body: some View {
        Map(coordinateRegion: $mapViewModel.region,
            showsUserLocation: true,
            userTrackingMode: .none)
            .onAppear {
                Task{
                    mapViewModel.checkIfLocationManagerIsEnable()
                   
                }
            }
    }
}
