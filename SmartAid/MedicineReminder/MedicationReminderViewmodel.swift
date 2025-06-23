//
//  MedicationReminderViewmodel.swift
//  SmartAid
//
//  Created by mohdanas on 17/06/25.
//

import Foundation
import UserNotifications


class MedicationReminderViewmodel:ObservableObject{
    @Published  var medicineName: String = ""
    @Published  var reminderTime: Date = Date()
    @Published  var repeatFrequency: String = "Daily"
    @Published  var reminders:[Reminder] = [] {
        didSet {      //when reminders array change savereminders call automatecally
            saveReminders()
        }
    }
    
    let repeatOptions = ["Daily", "Weekly", "Monthly"]
    private let key = "savedReminders"
    
    init(){
        NotificationManager.shared.requestPermission()
        loadReminders()
    }
    
    
    func addReminder(){
        
                let newReminder = Reminder(
                    medicineName: medicineName,
                    time: reminderTime,
                    repeatFrequency: repeatFrequency
                )

                reminders.append(newReminder)
                NotificationManager.shared.scheduleNotification(for: newReminder)
                // Clear input
                medicineName = ""
                reminderTime = Date()
                repeatFrequency = "Daily"
            
    }
    
    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter.string(from: date)
    }
    
    func deleteReminder(at offsets: IndexSet) {
        for index in offsets {
            let reminder = reminders[index]
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [reminder.id.uuidString])
        }
        reminders.remove(atOffsets: offsets)
    }
    
    private func saveReminders() {
            if let data = try? JSONEncoder().encode(reminders) {
                UserDefaults.standard.set(data, forKey: key)
            }
        }
    
    private func loadReminders() {
            guard let data = UserDefaults.standard.data(forKey: key),
                  let decoded = try? JSONDecoder().decode([Reminder].self, from: data)
            else { return }

            reminders = decoded
        }


}
