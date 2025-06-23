//
//  MedicineReminderView.swift
//  SmartAid
//
//  Created by mohdanas on 17/06/25.
//

import SwiftUI

struct MedicineReminderView: View {
    @StateObject private var viewModel = MedicationReminderViewmodel()

    
    var body: some View {
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
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            
            Divider()
            
            Text("Scheduled Reminders")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            List{
                ForEach(viewModel.reminders, id: \.self) { reminder in
                    
                    VStack(alignment: .leading) {
                        Text(reminder.medicineName)
                            .font(.headline)
                        Text("Time: \(viewModel.formattedTime(reminder.time)) | Repeat: \(reminder.repeatFrequency)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                }
                .onDelete(perform: viewModel.deleteReminder)
            }
        }
            .padding()
            .onAppear {
                NotificationManager.shared.requestPermission()
            }
            .navigationTitle("Medicine Reminder")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    
}

#Preview {
    MedicineReminderView()
}
