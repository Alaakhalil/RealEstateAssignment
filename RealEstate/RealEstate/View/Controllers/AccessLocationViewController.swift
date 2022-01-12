//
//  AccessLocationViewController.swift
//  RealEstate
//
//  Created by Alaa Khalil on 11/01/2022.
//

import UIKit
import CoreLocation

class AccessLocationViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }
}
