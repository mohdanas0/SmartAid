//
//  ContentView.swift
//  SmartAid
//
//  Created by mohdanas on 17/06/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var authVM = AuthenticationViewModel()
    var body: some View {
            if authVM.isLoggedIn {
                HomeView()
                    .environmentObject(authVM)
            }
            else{
                LoginView()
                    .environmentObject(authVM)
            }
       
    }
}

#Preview {
    ContentView()
}
