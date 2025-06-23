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
                
               
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 24) {
                    
                    NavigationLink(destination: SymtomCheckerBotView()) {
                        HomeButtonView(icon: "stethoscope", label: "Symptom\nChecker", color: .blue)
                    }
                    
                   
                    NavigationLink(destination: EmergencyContactView()) {
                        HomeButtonView(icon: "exclamationmark.triangle", label: "Emergency", color: .red)
                    }
                    
                   
                    NavigationLink(destination: MedicineReminderView()) {
                        HomeButtonView(icon: "pills", label: "Medicine\nReminder", color: .blue)
                    }
                    
                    // Emergency
                    NavigationLink(destination: EmergencyContactView()) {
                        HomeButtonView(icon: "exclamationmark.triangle", label: "Emergency", color: .red)
                    }
                }
                
                Spacer()
            }
            .padding()
            
        }
    }
}

#Preview {
    HomeView()
}
