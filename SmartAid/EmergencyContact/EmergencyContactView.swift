//
//  AddedContactView.swift
//  SmartAid
//
//  Created by mohdanas on 03/07/25.
//

import SwiftUI
import CoreLocation
struct EmergencyContactView: View {
    @ObservedObject var viewModel = EmergencyContactLocationViewModel()
    @ObservedObject var manager = LocationManager()
    @State private var locationSent: Bool = false
    @State var addContactView:Bool = false
    @State private var showToast = false
    @State private var toastMessage = ""
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),startPoint: .topLeading,endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack {
                if viewModel.contacts.isEmpty {
                    
                    noContactView
                    
                } else {
                    
                    lisrView
                    
                }
            }
            .overlay(
                Group {
                    if showToast {
                        Text(toastMessage)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .padding(.bottom, 40)
                    }
                },
                alignment: .bottom
            )
            
            
            
            
        }
        .navigationTitle("Emergency Contacts")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            Button{
                addContactView.toggle()
            }label: {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $addContactView) {
                AddContactView(viewModel:viewModel,isPresented:$addContactView)
            }
        }
        
    }
    
    func sendLocation(to contact: EmergencyContact, location: CLLocationCoordinate2D) {
        
        let message = "Hey! Here's my location: https://maps.google.com/?q=\(location.latitude),\(location.longitude)"
        
        
        let whatsappURL = "whatsapp://send?phone=\(contact.phone)&text=\(message)"
        if let url = URL(string: whatsappURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                let webURLString = "https://api.whatsapp.com/send?phone=\(contact.phone)&text=\(message)"
                if let webURL = URL(string: webURLString) {
                    UIApplication.shared.open(webURL)
                    print("ℹ️ WhatsApp not installed. Opened in browser instead.")
                }
                
            }
        }
        
        toastMessage = "📍 Location sent to \(contact.name)"
        withAnimation {
            showToast = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                showToast = false
            }
        }
    }
}

#Preview {
    EmergencyContactView()
}

extension EmergencyContactView {
    
    var noContactView : some View {
        VStack{
            VStack(spacing: 10) {
                Image(systemName: "person.crop.circle.badge.exclam")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
                Text("No emergency contacts added yet")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding()
        }
    }
    
    
    
    
    
    var lisrView: some View {
        VStack{
            List {
                ForEach(viewModel.contacts) { contact in
                    HStack{
                        VStack(alignment:.leading,spacing:3){
                            Text(contact.name).font(.headline)
                            Text(contact.phone).font(.subheadline).foregroundColor(.gray)
                        }
                        Spacer()
                        
                        if let loc = LocationManager.shared.location{
                            Button("Send Location") {
                                sendLocation(to: contact, location: loc)
                                locationSent = true
                            }
                            .font(.caption)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.red)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                            
                        }
                    }
                    .padding(.vertical,10)
                    .padding(.horizontal,10)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    
                    
                }
                .onDelete(perform: viewModel.deleteContact)
            }
            .listStyle(PlainListStyle())
        }
    }
}
