//
//  MedicineReminderListView.swift
//  SmartAid
//
//  Created by mohdanas on 11/07/25.
//

import SwiftUI

struct MedicineReminderListView: View {
    @ObservedObject var viewModel = MedicationReminderViewmodel()
    @State var showAddMedicineView :Bool = false
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.cyan.opacity(0.3), Color.indigo.opacity(0.3)]),startPoint: .topLeading,endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                if viewModel.reminders.isEmpty {
                    
                    VStack(spacing: 10) {
                        Image(systemName: "bell.slash")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color.gray)
                        Text("No Reminders added yet")
                            .foregroundColor(Color.gray)
                            .font(.headline)
                    }
                    .padding()
                    
                    
                } else {
                    
                    List{
                        ForEach(viewModel.reminders, id: \.self) { reminder in
                            VStack(alignment: .leading) {
                                Text(reminder.medicineName)
                                    .font(.headline)
                                    .foregroundStyle(Color.black)
                                Text("Time: \(viewModel.formattedTime(reminder.time)) | Repeat: \(reminder.repeatFrequency)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth:.infinity,alignment:.leading)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            
                        }
                        .onDelete(perform: viewModel.deleteReminder)
                    }
                    .listStyle(PlainListStyle())
                    
                }
            }
        }
        .navigationTitle("Medicine Reminders")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            Button{
                showAddMedicineView.toggle()
            }label: {
                Image(systemName: "plus")
            }
            .sheet(isPresented:$showAddMedicineView){
                AddMedicationReminderView(viewModel:viewModel,isPresented:$showAddMedicineView)
            }
        }
    }
}

#Preview {
    MedicineReminderListView()
}
