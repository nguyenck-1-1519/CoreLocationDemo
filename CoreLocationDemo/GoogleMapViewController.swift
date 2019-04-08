//
//  GoogleMapViewController.swift
//  CoreLocationDemo
//
//  Created by can.khac.nguyen on 4/8/19.
//  Copyright © 2019 can.khac.nguyen. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class GoogleMapViewController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!

    let defaultZoomLvl: Float = 16
    let customFlagMarker = #imageLiteral(resourceName: "flag")
    let customMarkerView = CustomMarkerView(frame: CGRect(x: 0, y: 0, width: 40, height: 60))
    let customInfoWindow = CustomInfoWindow(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    let listPoint = [
        CLLocationCoordinate2D(latitude: 21.016165517459584, longitude: 105.78376270830631),
        CLLocationCoordinate2D(latitude: 21.017777947272428, longitude: 105.78256107866764),
        CLLocationCoordinate2D(latitude: 21.010777271503517, longitude: 105.77290512621403),
        CLLocationCoordinate2D(latitude: 21.008606707349216, longitude: 105.77439207583666),
        CLLocationCoordinate2D(latitude: 21.003590032480766, longitude: 105.77358204871416),
        CLLocationCoordinate2D(latitude: 21.00152484616829, longitude: 105.78220769762993),
        CLLocationCoordinate2D(latitude: 20.99347040912345, longitude: 105.777627825737),
        CLLocationCoordinate2D(latitude: 20.990384303978267, longitude: 105.78297045081854),
        CLLocationCoordinate2D(latitude: 20.987466860209928, longitude: 105.7786463946104),
        CLLocationCoordinate2D(latitude: 20.981928568775025, longitude: 105.78761201351881),
    ]

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        configMapView()
        startStandardLocationService()
    }

    deinit {
        locationManager.stopUpdatingLocation()
    }

    func configMapView() {
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
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

extension GoogleMapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        let currentCameraPosition = GMSCameraPosition(target: location.coordinate, zoom: 16, bearing: 0, viewingAngle: 0)
        mapView.animate(to: currentCameraPosition)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            startStandardLocationService()
        default:
            print("bat lai ngayyyy")
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("faillll: \(error)")
    }

}

extension GoogleMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        let marker = GMSMarker(position: coordinate)
        marker.snippet = "lat: \(coordinate.latitude) -- lng: \(coordinate.longitude)"
        marker.title = "Marker"
        marker.icon = GMSMarker.markerImage(with: .blue)
        print(coordinate)
//        marker.icon = UIImage(named: "flag")
//        marker.icon = customFlagMarker
//        marker.iconView = customMarkerView
        marker.map = mapView
    }

    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        mapView.clear()
        let path = GMSMutablePath()
        for coor in listPoint {
            path.add(coor)
        }
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .purple
        polyline.strokeWidth = 2.0
        polyline.map = mapView
    }

    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return customInfoWindow
    }
}
