//
//  HomeView.swift
//  SmartAid
//
//  Created by mohdanas on 21/06/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                
                
                
                // App Title
                Text("SmartAid")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                
               
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 35) {
                    
                    NavigationLink(destination: SymtomCheckerBotView()) {
                        HomeButtonView(icon: "stethoscope", label: "Symptom\nChecker", color: .blue)
                    }
                    
                   
                    NavigationLink(destination: EmergencyContactView()) {
                        HomeButtonView(icon: "exclamationmark.triangle", label: "Emergency", color: .red)
                    }
                    
                   
                    NavigationLink(destination: MedicineReminderView()) {
                        HomeButtonView(icon: "pills", label: "Medicine\nReminder", color: .green)
                    }
                    
                    // Emergency
                    NavigationLink(destination: NearbyHospitalView()) {
                        HomeButtonView(icon: "building.2.crop.circle.fill", label: "NearbyHospital", color: .yellow)
                    }
                }
                
                Spacer()
                
                Text("SmartAid helps you manage your health by providing AI-powered symptom checking, medication reminders, and emergency support.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
            }
            .padding()
            
        }
    }
}

#Preview {
    HomeView()
}
