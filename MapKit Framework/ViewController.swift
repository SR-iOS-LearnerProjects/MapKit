//
//  ViewController.swift
//  MapKit Framework
//
//  Created by MAC006 on 13/02/20.
//  Copyright © 2020 MAC006. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

struct annotatedPlace {
    var name: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
}

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    let places = [
        annotatedPlace(name: "Krify", latitude: 17.022649, longitude: 82.2352018),
        annotatedPlace(name: "Emirates Stadium", latitude: 51.5549, longitude: -0.108436),
        annotatedPlace(name: "Stamford Bridge", latitude: 51.4816, longitude: -0.191034),
        annotatedPlace(name: "White Hart Lane", latitude: 51.6033, longitude: -0.065684),
        annotatedPlace(name: "Olympic Stadium", latitude: 51.5383, longitude: -0.016587),
        annotatedPlace(name: "Old Trafford", latitude: 53.4631, longitude: -2.29139),
        annotatedPlace(name: "Anfield", latitude: 53.4308, longitude: -2.96096)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        checkLocationServices()
        fetchPlacesOnMap(places)
        
    }

    func fetchPlacesOnMap(_ places: [annotatedPlace]) {
      for annotatedPlace in places {
        let annotations = MKPointAnnotation()
        annotations.title = annotatedPlace.name
        annotations.coordinate = CLLocationCoordinate2D(
            latitude: annotatedPlace.latitude,
            longitude: annotatedPlace.longitude
        )
        mapView.addAnnotation(annotations)
      }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // Check device wide location services enabled or not
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorizarionStatus()
        }
        else {
            
        }
    }
    
    // Display users location to center of the map view
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    // Checking authorization status
    func checkLocationAuthorizarionStatus() {
        switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
                centerViewOnUserLocation()
            
            case .denied: break
            
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                mapView.showsUserLocation = true
            
            case .restricted: break
            case .authorizedAlways: break
        }
    }

}


extension ViewController: CLLocationManagerDelegate {
    
    // Updates users current location based on users location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    // Checks for authorization changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorizarionStatus()
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func
    
}

