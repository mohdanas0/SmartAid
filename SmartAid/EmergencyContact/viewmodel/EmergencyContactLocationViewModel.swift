//
//  EmergencyContactLocationViewModel.swift
//  SmartAid
//
//  Created by mohdanas on 19/06/25.
//

import Foundation




class EmergencyContactLocationViewModel: ObservableObject {
    @Published var contacts: [EmergencyContact] = []

    private let key = "emergencyContacts"

    init() {
        loadContacts()
    }

    func addContact(name: String, phone: String) {
        let contact = EmergencyContact(name: name, phone: phone)
        contacts.append(contact)
        saveContacts()
    }

    func deleteContact(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
        saveContacts()
    }

    private func saveContacts() {
        if let data = try? JSONEncoder().encode(contacts) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func loadContacts() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let saved = try? JSONDecoder().decode([EmergencyContact].self, from: data)
        else { return }
        contacts = saved
    }
}

