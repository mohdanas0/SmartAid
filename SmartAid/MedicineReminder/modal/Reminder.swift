//
//  Reminder.swift
//  SmartAid
//
//  Created by mohdanas on 17/06/25.
//

import Foundation

struct Reminder: Identifiable,Hashable ,Codable{
    var id = UUID()
    var medicineName: String
    var time: Date
    var repeatFrequency: String
}
