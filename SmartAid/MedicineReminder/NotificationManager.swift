//
//  NotificationManager.swift
//  SmartAid
//
//  Created by mohdanas on 17/06/25.
//

import UserNotifications
import Foundation

class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            if granted {
                print("✅ Notification permission granted")
            } else {
                print("❌ Notification permission denied")
            }
        }
    }

    func scheduleNotification(for reminder: Reminder) {
        let content = UNMutableNotificationContent()
        content.title = "Time to take your medicine"
        content.body = reminder.medicineName
        content.sound = .default

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: reminder.time)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: reminder.repeatFrequency == "Daily")

        let request = UNNotificationRequest(identifier: reminder.id.uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Notification scheduling error: \(error)")
            } else {
                print("✅ Notification scheduled for \(reminder.medicineName)")
            }
        }
    }
}


