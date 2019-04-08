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
        map.delegate = self
//        startStandardLocationService()
//        startVisitLocationService()
        startSignificantUpdateLocationService()
    }

    deinit {
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringVisits()
    }

    private func getRegion(location: CLLocation) -> MKCoordinateRegion {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude)
        return MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.014,
                                                                               longitudeDelta: 0.014))
    }

    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
        -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            let geocoder = CLGeocoder()

            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    completionHandler(firstLocation)
                                                }
                                                else {
                                                    // An error occurred during geocoding.
                                                    completionHandler(nil)
                                                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
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

    func startVisitLocationService() {
        let authorationStatus = CLLocationManager.authorizationStatus()
        if authorationStatus != .authorizedWhenInUse && authorationStatus != .authorizedAlways {
            return
        }
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.startMonitoringVisits()
    }

    func startSignificantUpdateLocationService() {
        let authorationStatus = CLLocationManager.authorizationStatus()
        if authorationStatus != .authorizedWhenInUse && authorationStatus != .authorizedAlways {
            return
        }
        if !CLLocationManager.significantLocationChangeMonitoringAvailable() {
            return
        }
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.startMonitoringSignificantLocationChanges()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            // chú ý là hệ thống có thể cache lại locations, nên cần check cả timestamp của location
            return
        }
        print("lat: - \(location.coordinate.latitude) - long: - \(location.coordinate.longitude) - time: - \(location.timestamp)")
        map.setRegion(getRegion(location: location), animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        print("coordinate: \(visit.coordinate) - arrival date: - \(visit.arrivalDate)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            locationManager.stopUpdatingLocation()
            return
        }
        // error
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        lookUpCurrentLocation { place in
            print(place)
        }
    }
}

