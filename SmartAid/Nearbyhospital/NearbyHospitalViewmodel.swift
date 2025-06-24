//
//  NearbyHospitalViewmodel.swift
//  SmartAid
//
//  Created by mohdanas on 23/06/25.
//

import Foundation
import MapKit

class NearbyHospitalViewmodel: ObservableObject {
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var hospitals: [Place] = []
    private var locationCheckTimer: Timer?

    func fetchNearbyHospitals(onComplete: @escaping () -> Void) {
        guard let coord = LocationManager.shared.location else {
            print("⏳ Location not ready. Waiting...")
            waitForLocation(onComplete)
            return
        }

        print("📍 Using location: \(coord.latitude), \(coord.longitude)")

        self.region = MKCoordinateRegion(
            center: coord,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Hospital"
        request.region = self.region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            DispatchQueue.main.async {
                if let items = response?.mapItems {
                    self.hospitals = items.map {
                        Place(name: $0.name ?? "Unknown", coordinate: $0.placemark.coordinate)
                    }
                }
                onComplete() // ✅ Notify view that data is ready
            }
        }
    }

    private func waitForLocation(_ onComplete: @escaping () -> Void) {
        locationCheckTimer?.invalidate()
        locationCheckTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if let _ = LocationManager.shared.location {
                timer.invalidate()
                self.fetchNearbyHospitals(onComplete: onComplete)
            }
        }
    }

    func openInMaps(_ place: Place) {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: place.coordinate))
        mapItem.name = place.name
        mapItem.openInMaps(launchOptions: nil)
    }
}
