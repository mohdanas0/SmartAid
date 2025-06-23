//
//  HomeButtonView.swift
//  SmartAid
//
//  Created by mohdanas on 21/06/25.
//

import SwiftUI

struct HomeButtonView: View {
        let icon: String
        let label: String
        let color: Color
    var body: some View {
        VStack(spacing: 12) {
                    
                    Spacer()
            
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width:36,height: 36)
                        .foregroundStyle(.white)
                        .padding(16)
                        .background(color)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                    Text(label)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.subheadline)
                        .foregroundColor(.primary)
            
                     Spacer()
                }
        .frame(height:149)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(20)
            }
        
    
}

#Preview {
    HomeButtonView(icon: "stethoscope", label: "Symptom\nChecker", color: .blue)
}
