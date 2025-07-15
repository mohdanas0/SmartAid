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
                    NavigationLink(destination: SymptomCheckerBotView()) {
                        HomeButtonView(icon: "stethoscope", label: "Symptom\nChecker", color: Color.blue)
                    }

                    NavigationLink(destination: EmergencyContactView()) {
                        HomeButtonView(icon: "exclamationmark.triangle", label: "Emergency\nContact", color: Color.red)
                    }

                    NavigationLink(destination: MedicineReminderListView()) {
                        HomeButtonView(icon: "pills", label: "Medicine\nReminder", color: Color.green)
                    }

                    NavigationLink(destination: NearbyHospitalView()) {
                        HomeButtonView(icon: "building.2.crop.circle", label: "Nearby\nHospital", color: Color.yellow)
                    }
                }

                Spacer()

                Text("SmartAid helps you manage your health by providing AI-powered symptom checking, medication reminders, and emergency support.")
                    .font(.footnote)
                    .foregroundColor(Color.gray)
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
                            .foregroundStyle(Color.blue)
                           
                
                
                    
                }
            }
            
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthenticationViewModel())
}
