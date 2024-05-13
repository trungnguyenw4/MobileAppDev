//
//  Location.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 07/05/2024.
//

import Foundation
import MapKit

struct PlaceAnnotation: Identifiable {
   let id = UUID()
   var selected: Bool = false
   var name: String
   var location: CLLocationCoordinate2D

   init(name: String, location: CLLocationCoordinate2D) {
      self.name = name
      self.location = location
   }
}
