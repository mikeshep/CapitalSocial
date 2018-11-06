//
//  MapViewController.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/6/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    let regionRadius: CLLocationDistance = 1000
    let annotation = MKPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Ubicación"
        
        mapView.showsUserLocation = true
        
        //Set initial location
        let initialLocation = CLLocation(latitude: location.lat, longitude: location.long)
        centerMapOnLocation(location: initialLocation)
        
        //add pin to mapview
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
        mapView.addAnnotation(annotation)
        
        if (CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}
