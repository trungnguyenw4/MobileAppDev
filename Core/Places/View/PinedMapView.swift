//
//  PinedMapView.swift
//  WhatzAround
//
//  Created by Trung Nguyen on 12/05/2024.
//


import SwiftUI
import MapKit


struct PinedMapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var annotations: [FamousPlaces]

    
    
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)

        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        uiView.setRegion(region, animated: true)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }

            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            annotationView.canShowCallout = true

            if let title = annotation.title {
                if title == "Restaurant" {
                    annotationView.pinTintColor = .green
                } else {
                    annotationView.pinTintColor = .red
                }

                let label = UILabel()
                label.numberOfLines = 0
                label.text = title
                annotationView.detailCalloutAccessoryView = label
            }
            return annotationView
        }
    }
}


