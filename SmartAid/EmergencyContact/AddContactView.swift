//
//  EmergencyContactView.swift
//  SmartAid
//
//  Created by mohdanas on 19/06/25.
//

import SwiftUI
import CoreLocation

struct AddContactView: View {
        @State private var contactName: String = ""
        @State private var phoneNumber: String = ""
      @ObservedObject var viewModel:EmergencyContactLocationViewModel
       @ObservedObject var manager = LocationManager()
        @State private var locationSent: Bool = false
    @Binding var isPresented:Bool
    var body: some View {
        ZStack {
            LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.3), Color.blue.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            
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
                            isPresented = false
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                
                Text(LocationManager.shared.location == nil ? "📍 Location is not found try to open GPS" : "✅ Location loaded")
                    .foregroundColor(LocationManager.shared.location == nil ? .gray : .green)
                    .font(.caption)
                
                
            }
            .padding()
        }
    }

    
}

#Preview {
    AddContactView(viewModel: EmergencyContactLocationViewModel(), isPresented: .constant(false))
}
