//
//  AppDelegate.swift
//  CoreLocationDemo
//
//  Created by can.khac.nguyen on 4/4/19.
//  Copyright © 2019 can.khac.nguyen. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let apiKey = "AIzaSyCputDcGfiachHfbS_Pnr01CDgp8lxNC-I"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(apiKey)
        GMSPlacesClient.provideAPIKey(apiKey)
        return true
    }

}

