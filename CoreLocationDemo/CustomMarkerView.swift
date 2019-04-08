//
//  CustomMarkerView.swift
//  CoreLocationDemo
//
//  Created by can.khac.nguyen on 4/5/19.
//  Copyright © 2019 can.khac.nguyen. All rights reserved.
//

import MapKit

class CustomMarkerView: NSObject, MKAnnotation {
    @objc dynamic var coordinate = CLLocationCoordinate2D(latitude: 21.016675639999962, longitude: 105.78449393999996)
    var title: String?
    var subtitle: String?
}
