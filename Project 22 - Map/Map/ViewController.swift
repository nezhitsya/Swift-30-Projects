//
//  ViewController.swift
//  Map
//
//  Created by 이다영 on 2021/05/03.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    private let regionRadius: CLLocationDistance = 1000
    private var artworks = [Artwork]()
    private var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.addAnnotation(artworks)
        
        centerMapOnLocation(location: initialLocation)
        loadInitialData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    private func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        
    }
    
    private func loadInitialData() {
        
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view: MKPinAnnotationView?
        
        if let annotation = annotation as? Artwork {
            let identifier = "pin"
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view?.canShowCallout = true
                view?.calloutOffset = CGPoint(x: -5, y: 5)
                view?.pinTintColor = annotation.pinColor()
                view?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
