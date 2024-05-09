//
//  PlacesViewModel.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 07/05/2024.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit
import Combine

//there is a button for entering data, fixed termm search

class LocationViewModel: NSObject,  ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapLocation: String = ""
    
    @Published var coordinates: CLLocationCoordinate2D?
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    
    @Published var locationManager: CLLocationManager?
    
    @Published var annotations: [PlaceAnnotation] = [] // Published property to hold place annotations.
    
    
//    var mapLocationPublisher: AnyPublisher<String, Never> {
//            $mapLocation.eraseToAnyPublisher()
//        }
    
    func checkIfLocationManagerIsEnable(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }
        else {
            print( "Please turn on your locationManager service")
        }
    }
    
    func checkLocationAuthoziration(){
        guard let locationManager = locationManager else {return }
        
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location service is restricted")
        case .denied:
            print("Your location service is being denied. Go into settings to enable it")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
        @unknown default:
            break
        }
    }
    
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
            checkLocationAuthoziration()
        }
        
        func getCoordinates() async throws {
            let geocoder = CLGeocoder()
            if let placemarks = try? await geocoder.geocodeAddressString(mapLocation),
               let location = placemarks.first?.location?.coordinate {
                
                DispatchQueue.main.async {
                    self.coordinates = location
                    self.region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                }
                
            } else {
                // Handle error here if geocoding fails
                print("Error: Unable to find the coordinates for the club.")
                
            }
        }
        
        func setAnnotations() async throws {
            let request = MKLocalSearch.Request()
            print("0...request:   ", request)
            request.naturalLanguageQuery = "chemist"
            request.region = region
            
            let search = MKLocalSearch(request: request)
            if let results = try? await search.start() {
                let items = results.mapItems
                print(items.count)
                for item in items {
                    print("1...coordinate:  ",item.placemark.coordinate)
                    print("2...name:  ",item.name ?? "undefined")
                    print("3...item:  ", item)
                    print("4...address:  ",item.placemark.thoroughfare ?? "Undefined")
                }
                DispatchQueue.main.async
                {
                    self.annotations = []
                    for item in items {
                        //print(item.name as Any)
                        if let location = item.placemark.location?.coordinate {
                            let place = PlaceAnnotation(name: item.name ?? "Undefined", location: location)
                            self.annotations.append(place)
                        }
                    }
                }
                
            }
        }
    }

