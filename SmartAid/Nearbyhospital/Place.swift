//
//  Place.swift
//  SmartAid
//
//  Created by mohdanas on 23/06/25.
//

import Foundation


import MapKit

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
