📱 SmartAid – Personal Health Assistant
SmartAid is an iOS SwiftUI-based health app designed to support users in managing their wellness. It offers AI-powered symptom checking, medication reminders, emergency contact location sharing, and nearby hospital detection using MapKit.

Why SmartAid?
This project aims to simplify the development of health-focused apps with robust features and seamless integrations. The core features include:

🗺️ Location & Nearby Hospital Discovery:-  Leverages real-time location data to help users find nearby healthcare facilities.

🆘 Emergency Contact & Safety Management:-  Facilitates quick sharing of location and emergency contacts to enhance user safety.

💊 Medication Reminders:-  Supports personalized medication schedules with notifications to improve adherence.

🤖 Symptom Checker & Al Chat:- Provides conversational health assistance through integrated Al chat capabilities.

🛠️ Modular & Scalable Architecture: Built with reusable components and reliable package management for efficient development.


🛠️ Built With
SwiftUI, MapKit, CoreLocation, UserNotifications
Firebase Auth
Hugging Face Inference API (Flan-T5 model)
Local data storage

📂 Project Structure
SmartAid/
├── Authentication/             # Firebase login & signup screens
├── EmergencyContact/           # Contact manager, location sharing
├── MedicationReminder/         # Reminder list & scheduling
├── NearbyHospitals/            # Map with search and pin annotation
├── SymptomChecker/             # ChatView integrated with Hugging Face
├── Managers/                   # LocationManager, NotificationManager
├── Assets/                     # App icons, color sets
├── Utilities/                  # Reusable components and helpers
└── SmartAidApp.swift           # Entry point


🚀 Getting Started
Clone the repo
git clone https://github.com/mohdanas0/SmartAid.git


