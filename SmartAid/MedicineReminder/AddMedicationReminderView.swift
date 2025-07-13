//
//  MedicineReminderView.swift
//  SmartAid
//
//  Created by mohdanas on 17/06/25.
//

import SwiftUI

struct AddMedicationReminderView: View {
    
    @ObservedObject  var viewModel : MedicationReminderViewmodel
    @Binding var isPresented : Bool

    
    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.3), Color.blue.opacity(0.3)]),startPoint: .topLeading,endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Input Fields
                Group {
                    TextField("Medicine Name", text: $viewModel.medicineName )
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    DatePicker("Time", selection: $viewModel.reminderTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    Picker("Repeat", selection: $viewModel.repeatFrequency) {
                        ForEach(viewModel.repeatOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                
                Button("Set Reminder") {
                    viewModel.addReminder()
                    isPresented = false
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                
                
                
            }
            .padding()
            .onAppear {
                NotificationManager.shared.requestPermission()
            }
        }
          
        }
        
        
    
}

#Preview {
    AddMedicationReminderView(viewModel:MedicationReminderViewmodel(),isPresented: .constant(false))
}
