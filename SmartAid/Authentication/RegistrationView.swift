//
//  RegistrationView.swift
//  SmartAid
//
//  Created by mohdanas on 25/06/25.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var authVM : AuthenticationViewModel
    @State private var fullName = ""
    @State private var password = ""
    @State private var email = ""
    @State private var showPassword = false
    var body: some View {
        VStack{
            HeaderView(text: "Get Started.\nCreate an account")

            VStack(spacing:44){
               CustomTextField(imageName: "envelope", placeholder: "Email", text: $email)
                    .onChange(of: email){  authVM.clearError() }
                    .textInputAutocapitalization(.none)
                
                
                CustomTextField(imageName: "person", placeholder: "Full name", text: $fullName)
                
                CustomSecureField(imageName: "lock", placeholder: "Password", text: $password,showPassword: $showPassword)
                    .onChange(of: password){  authVM.clearError() }
                
                   
            }
            .padding(.horizontal,32)
            .padding(.top,44)
            
            if(authVM.isLoading){
                ProgressView()
            }else{
                Button{
                    authVM.signUp(email: email, password: password,name: fullName)
                }label: {
                    Text("Sign Up")
                        .font(.headline)
                        .frame(width: 340,height: 50)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .padding()
                }
                
                if !authVM.errorMessage.isEmpty {
                               Text(authVM.errorMessage)
                                   .foregroundColor(.red)
                           }
                
            }
            
            Spacer()
            
            NavigationLink{
               LoginView()
                    .navigationBarHidden(true)
            }label: {
                HStack {
                    Text("Already have an account?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                        
                    
                    Text("Sign In")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                    
                }
                
            }
            .padding(.bottom,32)
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
       
    }
}

#Preview {
    RegistrationView()
        .environmentObject(AuthenticationViewModel())
}
