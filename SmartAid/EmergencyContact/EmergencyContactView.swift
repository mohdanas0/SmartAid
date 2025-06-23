//
//  EmergencyContactView.swift
//  SmartAid
//
//  Created by mohdanas on 19/06/25.
//

import SwiftUI
import CoreLocation

struct EmergencyContactView: View {
    @State private var contactName: String = ""
        @State private var phoneNumber: String = ""
        @ObservedObject var viewModel = EmergencyContactLocationViewModel()
        @ObservedObject var locationManager = LocationManager()
        @State private var locationSent: Bool = false
    var body: some View {
        VStack(spacing: 24) {
                   Group {
                       TextField("Contact Name", text: $contactName)
                           .padding()
                           .background(Color(.systemGray6))
                           .cornerRadius(10)

                       TextField("Phone Number", text: $phoneNumber)
                           .keyboardType(.phonePad)
                           .padding()
                           .background(Color(.systemGray6))
                           .cornerRadius(10)

                       Button("Add Contact") {
                           if !contactName.isEmpty && !phoneNumber.isEmpty {
                               viewModel.addContact(name: contactName, phone: phoneNumber)
                               contactName = ""
                               phoneNumber = ""
                           }
                       }
                       .foregroundColor(.white)
                       .frame(maxWidth: .infinity)
                       .padding()
                       .background(Color.blue)
                       .cornerRadius(10)
                   }
            
            Text(locationManager.location == nil ? "📍 Location is nil" : "✅ Location loaded")
                        .foregroundColor(locationManager.location == nil ? .gray : .green)
                        .font(.caption)

                   Divider()

                   Text("Emergency Contacts")
                       .font(.headline)
                       .frame(maxWidth: .infinity, alignment: .leading)

                   List {
                       ForEach(viewModel.contacts) { contact in
                           VStack(alignment: .leading) {
                               Text(contact.name).font(.headline)
                               Text(contact.phone).font(.subheadline).foregroundColor(.gray)

                               if let loc = locationManager.location {
                                   Button("Send Location") {
                                       sendLocation(to: contact, location: loc)
                                       locationSent = true
                                   }
                                   .font(.caption)
                                   .foregroundColor(.red)
                               }
                           }
                       }
                       .onDelete(perform: viewModel.deleteContact)
                   }

                   if locationSent {
                       Text("✅ Location sent!")
                           .foregroundColor(.green)
                   }

                   Spacer()
               }
               .padding()
               .navigationTitle("Emergency Contact")
               .navigationBarTitleDisplayMode(.inline)
               
           }

           func sendLocation(to contact: EmergencyContact, location: CLLocationCoordinate2D) {
               print("📍 Sending location to \(contact.name): \(contact.phone)")
               print("Location: https://maps.google.com/?q=\(location.latitude),\(location.longitude)")
           }
    
}

#Preview {
    EmergencyContactView()
}
