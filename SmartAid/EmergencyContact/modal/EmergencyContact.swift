//
//  EmergencyContact.swift
//  SmartAid
//
//  Created by mohdanas on 19/06/25.
//

import Foundation

struct EmergencyContact: Identifiable, Codable {
    var id = UUID()
    var name: String
    var phone: String
}

