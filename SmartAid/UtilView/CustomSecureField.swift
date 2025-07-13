//
//  CustomSecureField.swift
//  SmartAid
//
//  Created by mohdanas on 25/06/25.
//

import SwiftUI

struct CustomSecureField: View {
    let imageName:String
    let placeholder:String
    @Binding var text : String
    @Binding var  showPassword : Bool
    var body: some View {
        if showPassword {
            HStack{
                CustomTextField(imageName: "lock", placeholder: "Password", text: $text)
                    .overlay(alignment:.trailing){
                        Button{
                            showPassword = false
                        }label: {
                            Image(systemName: "eye.fill")
                                .foregroundStyle(Color.primary)
                        }
                    }
                
               
            }
        }else {
            VStack {
                HStack{
                    Image(systemName: "lock")
                        .resizable()
                        .scaledToFit()
                        .frame(width:20,height: 20)
                    
                   SecureField("Password",text: $text)
                        .overlay(alignment:.trailing){
                            Button{
                                showPassword = true
                            }label: {
                                Image(systemName: "eye.slash.fill")
                                    .foregroundStyle(Color.primary)
                            }
                        }
                        .autocorrectionDisabled()
                        
                }
                
                Divider()
                    .background(Color(.darkGray))
            }
            
           
        }
    }
}

#Preview {
    CustomSecureField(imageName: "eye.fill", placeholder: "PAssword", text: .constant(""), showPassword: .constant(false))
}
