//
//  CustomTextField.swift
//  SmartAid
//
//  Created by mohdanas on 25/06/25.
//

import SwiftUI

struct CustomTextField: View {
    let imageName:String
    let placeholder:String
    @Binding var text : String
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width:20,height: 20)
                
                TextField(placeholder,text:$text)
                   
            }
            
            Divider()
                .background(Color(.darkGray))
        }
    }
}

#Preview {
    CustomTextField(imageName:"envelope",placeholder: "emsil",text: .constant(""))
}
