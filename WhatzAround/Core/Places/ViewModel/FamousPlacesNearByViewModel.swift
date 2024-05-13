//
//  FamousPlacesNearByViewModel.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 12/05/2024.
//

import Foundation
import SwiftUI
import MapKit
import Combine


class FamousPlacesNearByViewModel: ObservableObject {
    @ObservedObject var mapViewModel = LocationViewModel()
    @Published var locationText: String = ""
    @Published var isSubmitEnabled = false
    @Published var coordinate: CLLocationCoordinate2D?
    @Published var annotations: [FamousPlaces] = []

    private var cancellables = Set<AnyCancellable>()

    func submitButtonAction() {
        print(locationText)
        print(mapViewModel.mapLocation)
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationText) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                print("Error geocoding location: \(error?.localizedDescription ?? "")")
                return
            }
            self?.coordinate = placemark.location?.coordinate
        }
    }

    func searchPlaces(query: String) {
        guard let coordinate = coordinate else { return }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let response = response, error == nil else {
                print("Error searching for places: \(error?.localizedDescription ?? "")")
                return
            }

            let uniquePlaceNames = Set(response.mapItems.compactMap { $0.name })
            let annotations = uniquePlaceNames.compactMap { name in
                FamousPlaces(coordinate: response.mapItems.first(where: { $0.name == name })!.placemark.coordinate, title: name)
            }

            self?.annotations = annotations
        }
    }
    
    }
