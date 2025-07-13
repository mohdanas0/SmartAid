//
//  HomeView.swift
//  SmartAid
//
//  Created by mohdanas on 21/06/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authVM: AuthenticationViewModel
    @State var showEmergencyContactView = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                // ✅ Your custom title
                Text("SmartAid")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 35) {
                    NavigationLink(destination: SymtomCheckerBotView()) {
                        HomeButtonView(icon: "stethoscope", label: "Symptom\nChecker", color: .blue)
                    }

                    NavigationLink(destination: EmergencyContactView()) {
                        HomeButtonView(icon: "exclamationmark.triangle", label: "Emergency\nContact", color: .red)
                    }

                    NavigationLink(destination: MedicineReminderListView()) {
                        HomeButtonView(icon: "pills", label: "Medicine\nReminder", color: .green)
                    }

                    NavigationLink(destination: NearbyHospitalView()) {
                        HomeButtonView(icon: "building.2.crop.circle", label: "Nearby\nHospital", color: .yellow)
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                        Text("Logout")
                            .onTapGesture{
                                authVM.signOut()
                            }
                            .foregroundStyle(.blue)
                           
                
                
                    
                }
            }
            
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthenticationViewModel())
}
