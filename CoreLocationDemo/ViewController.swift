//
//  ViewController.swift
//  CoreLocationDemo
//
//  Created by can.khac.nguyen on 4/4/19.
//  Copyright © 2019 can.khac.nguyen. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!

    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        map.showsUserLocation = true
        startStandardLocationService()
    }

    func startStandardLocationService() {
        let authorationStatus = CLLocationManager.authorizationStatus()
        if authorationStatus != .authorizedWhenInUse && authorationStatus != .authorizedAlways {
            return
        }
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 100.0
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        print("lat: - \(location.coordinate.latitude) - \(location.coordinate.longitude)")
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.014,
                                                                               longitudeDelta: 0.014))
        map.setRegion(region, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            locationManager.stopUpdatingLocation()
            return
        }
        // error
    }
}

