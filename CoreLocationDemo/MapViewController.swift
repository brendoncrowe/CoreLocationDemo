//
//  ViewController.swift
//  CoreLocationDemo
//
//  Created by Brendon Crowe on 4/4/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let locationSession = CoreLocationSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertPlaceNameToCoordinate()
        
        // configure map view
        mapView.showsUserLocation = true
        mapView.delegate = self
        loadMapView()
    }
    
    private func makeAnnotations() -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        for location in Location.getLocations() {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = location.title
            annotations.append(annotation)
        }
        return annotations
    }
    
    private func loadMapView() {
        // get annotations for the map
        let annotations = makeAnnotations()
        mapView.addAnnotations(annotations)
        mapView.showAnnotations(annotations, animated: true)
    }

    private func convertCoordinateToPlaceMark() {
        let location = Location.getLocations()[1]
        locationSession.convertCoordinateToPlaceMark(coordinate: location.coordinate)
    }
    
    private func convertPlaceNameToCoordinate() {
        let name = "miami"
        locationSession.convertPlaceNameToCoordinate(addressString: name)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("didSelect")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("calloutAccessoryControlTapped")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        let identifier = "locationAnnotation"
        var annotationView: MKMarkerAnnotationView
        
        // try to dequeue and reuse annotation view
        if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            annotationView = dequeueView
        } else {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
        }
        return annotationView
    }
}
