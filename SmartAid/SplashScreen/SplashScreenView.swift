//
//  SpashScreenView.swift
//  SmartAid
//
//  Created by mohdanas on 12/07/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive:Bool = false
    var body: some View {
        
            VStack{
                if isActive {
                    ContentView()
                        
                }else {
                    ZStack{
                        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .ignoresSafeArea()
                        
                        VStack(spacing: 20) {
                            Image("smartaidlogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .foregroundColor(Color.primary)
                            
                            
                            
                            
                            Text("SmartAid")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.primary)
                                .shadow(radius: 5)
                            
                            Text("Your Personal health assistant")
                                .font(.headline)
                                .foregroundColor(Color.primary)
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        
        
    }
    
}

#Preview {
    SplashScreenView()
}

