//
//  CoreLocationSession.swift
//  CoreLocationDemo
//
//  Created by Brendon Crowe on 4/4/23.
//

import Foundation
import CoreLocation

class CoreLocationSession: NSObject {
    
    public var locationManager: CLLocationManager
    
    override init() { // must mark with override if inheriting from NSObject
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        
    }
}

extension CoreLocationSession: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError: \(error)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) { // the state of access for location services
        switch manager.authorizationStatus {
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .denied:
            print("denied")
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("didEnterRegion")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("didExitRegion")
    }
    
}
