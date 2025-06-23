//
//  LocationManager.swift
//  SmartAid
//
//  Created by mohdanas on 19/06/25.
//

import Foundation


import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else { 
            print("No location found")
            return }
        print("📍 Location updated: \(loc.coordinate.latitude), \(loc.coordinate.longitude)")
        DispatchQueue.main.async {
                   self.location = loc.coordinate
               }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("❌ Location update failed: \(error.localizedDescription)")
        }
}
