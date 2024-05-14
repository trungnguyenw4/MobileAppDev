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

//there is a button for entering data, fixed termm search

class LocationViewModel: NSObject,  ObservableObject, CLLocationManagerDelegate {
    
    //@Published var currentUser: User?
    
    @Published var mapLocation: String = ""
    
    @Published var coordinates: CLLocationCoordinate2D?
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    
    @Published var locationManager: CLLocationManager?
    
    //@Published var annotations: [PlaceAnnotation] = [] // Published property to hold place annotations.
    
    
    //    var mapLocationPublisher: AnyPublisher<String, Never> {
    //            $mapLocation.eraseToAnyPublisher()
    //        }
    
    
//    func updateLocationOnFirebase(currentUser:User) async {
//        
//        
//        let db = Firestore.firestore()
//        let documentRef = db.collection("users").document(currentUser.id)
//
//        do {
//            let document = try await documentRef.getDocument()
//            
//            if document.exists {
//                // Document exists, update the country field
//                try await documentRef.updateData(["location": self.mapLocation])
//                print("Document successfully updated")
//            } else {
//                print("Document does not exist")
//            }
//        } catch {
//            print("Error updating document: \(error)")
//        }
//    }
    
    
    
    func checkIfLocationManagerIsEnable(){
        //let geocoder = CLGeocoder()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            //guard let locationManager = locationManager else {return }
            locationManager!.delegate = self
            print("1st check")
            print(locationManager!.location)
            
            getRegion()
           
            
        }
        else {
            print( "Please turn on your locationManager service")
        }
    }
    
    func checkLocationAuthoziration(){
        //let geocoder = CLGeocoder()
        guard let locationManager = locationManager else {return }
        
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location service is restricted")
        case .denied:
            print("Your location service is being denied. Go into settings to enable it")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate  , span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            
           //CLLocationCoordinate2D(latitude: 40, longitude: 120)
            
        @unknown default:
            break
        }
    }
    
    func getRegion()  {
        
        guard let locationManager = locationManager
        
        
        else {return }
        print("2nd check")
        print(locationManager.location)
        
        getPlacemark(forLocation: locationManager.location! ) {
            (originPlacemark, error) in
                if let err = error {
                    print(err)
                } else if let placemark = originPlacemark {
                    self.mapLocation = placemark.subAdministrativeArea ?? ""
                    
//                    print( placemark.areasOfInterest?.first)
//                    print( placemark.administrativeArea)
//                    print( placemark.subAdministrativeArea)
//                    print( placemark.subLocality)
                }
            }
        }
        
    
        //let userRegion = geocoder.reverseGeocodeLocation(locationManager.location!)
            
         
        
              // print(userRegion)
                
    
    
                
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
                    //self.annotations = []
                    for item in items {
                        //print(item.name as Any)
                        if let location = item.placemark.location?.coordinate {
                            let place = PlaceAnnotation(name: item.name ?? "Undefined", location: location)
                            //self.annotations.append(place)
                        }
                    }
                }
                
            }
        }
    }

