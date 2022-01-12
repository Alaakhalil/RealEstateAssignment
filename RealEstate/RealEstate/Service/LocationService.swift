//
//  LocationService.swift
//  RealEstate
//
//  Created by Alaa Khalil on 09/01/2022.
//

import Foundation
import CoreLocation

enum Result<T> {
    case success(T)
    case failure(Error)
}

  class LocationService: NSObject {
      private var manager : CLLocationManager
    
    init(manager: CLLocationManager = .init()) {
        self.manager = manager
        super.init()
        manager.delegate = self
    }
    
    var newLocation: ((Result<CLLocation>) -> Void)?
    
    var didChangeStatus: ((Bool) -> Void)?
    
    // Return User current authorization status
    var status: CLAuthorizationStatus {
        return self.manager.authorizationStatus
    }
    
    func requestLocationAuthorization() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
      
    // Return Current User Location
    func userLocation()-> (CLLocation){
        return manager.location!
    }
    func getLocation() {
        manager.startUpdatingLocation()
        manager.requestLocation()
    }
}
// Request updates for user location
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        newLocation?(.failure(error))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.sorted(by: {$0.timestamp > $1.timestamp}).first {
            newLocation?(.success(location))
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined, .restricted, .denied:
            didChangeStatus?(false)
        default:
            didChangeStatus?(true)
        }
    }
}
