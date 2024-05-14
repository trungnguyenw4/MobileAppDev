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
import FirebaseFirestore



class LocationViewModel: NSObject,  ObservableObject, CLLocationManagerDelegate {
    
    
    @Published var mapLocation: String = ""
    
    @Published var coordinates: CLLocationCoordinate2D?
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    
    @Published var locationManager: CLLocationManager?
    
    
    
    func checkIfLocationManagerIsEnable(){
       
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            
            locationManager?.delegate = self
            print("1st check")
            print(locationManager!.location)
            
           
           
            
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
            region = MKCoordinateRegion(center: locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 40, longitude: 120)  , span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            getRegion()
            
           //
            
        @unknown default:
            break
        }
    }
    
    func getRegion()  {
        
        guard let locationManager = locationManager else {return }
        print("2nd check")
        print(locationManager.location)
        // we have guard let above, so we are safe to do the below operation
        // we could have done the same for the above function but I just want to see how complex it is.
        getPlacemark(forLocation: locationManager.location! ) {
            (originPlacemark, error) in
                if let err = error {
                    print(err)
                } else if let placemark = originPlacemark {
                    self.mapLocation = placemark.subAdministrativeArea ?? ""
                    
                }
            }
        }
        
    
    
                
    func getPlacemark(forLocation location: CLLocation, completionHandler: @escaping (CLPlacemark?, String?) -> ()) {
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location, completionHandler: {
            placemarks, error in

            if let err = error {
                completionHandler(nil, err.localizedDescription)
            } else if let placemarkArray = placemarks {
                if let placemark = placemarkArray.first {
                    completionHandler(placemark, nil)
                    
       
                    
                } else {
                    completionHandler(nil, "Placemark was nil")
                }
            } else {
                completionHandler(nil, "Unknown error")
            }
        })

       
        
    }
    
    //cai nay work, dang thu cai moi
    
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
        
    
    }

