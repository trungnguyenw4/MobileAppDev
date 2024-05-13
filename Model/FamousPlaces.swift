//
//  FamousPlaces.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 12/05/2024.
//

import Foundation
import MapKit

class FamousPlaces: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?

    init(coordinate: CLLocationCoordinate2D, title: String?) {
        self.coordinate = coordinate
        self.title = title
    }
}
