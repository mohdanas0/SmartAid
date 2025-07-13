//
//  HeaderView.swift
//  SmartAid
//
//  Created by mohdanas on 25/06/25.
//

import SwiftUI

struct HeaderView: View {
    let text:String
    var body: some View {
        ZStack(alignment:.bottomLeading){
            Color.blue
            VStack(){
                Text(text)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    
            }
            .foregroundColor(.white)
            .padding(.horizontal,20)
            .padding(.vertical,40)
        }
        .frame(height:260)
        .clipShape(RoundedShape(corners: [.bottomRight], radius: 80))

    }
}

#Preview {
    HeaderView(text: "Hello\nWlecomeBack")
}
