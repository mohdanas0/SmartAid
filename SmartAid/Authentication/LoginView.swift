//
//  LoginView.swift
//  SmartAid
//
//  Created by mohdanas on 25/06/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM :AuthenticationViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    var body: some View {
       //parent container
        VStack{
            //header cont.
            HeaderView(text: "Hello,\nWelcome Back")
            VStack(spacing:44){
               CustomTextField(imageName: "envelope", placeholder: "Email", text: $email)
                    .onChange(of: email){  authVM.clearError() }
                    .textInputAutocapitalization(.none)
                
                CustomSecureField(imageName: "lock", placeholder: "Password", text: $password,showPassword: $showPassword)
                    .onChange(of: password){  authVM.clearError() }
                   
            }
            .padding(.horizontal,32)
            .padding(.top,44)
            
            if !authVM.errorMessage.isEmpty {
                Text(authVM.errorMessage)
                    .foregroundColor(Color.red)
                               .font(.caption)
                       }
                
            
            HStack {
                Spacer()
                
                NavigationLink{
                    Text("Reset password here...")
                }label: {
                    Text("Forgot Password?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.blue)
                        .padding(.top)
                        .padding(.trailing,32)
                    
                }
            }
            if(authVM.isLoading){
                ProgressView()
            }else{
                Button{
                    authVM.signIn(email: email, password: password)
                }label: {
                    Text("Sign In")
                        .font(.headline)
                        .frame(width: 340,height: 50)
                        .background(.blue)
                        .foregroundStyle(Color.white)
                        .clipShape(Capsule())
                        .padding()
                }
                .padding(.top,34)
                .shadow(color: .gray.opacity(0.5), radius: 10,x: 0,y: 0)
                
            }
        
            Spacer()
            
            NavigationLink{
               RegistrationView()
                    .navigationBarHidden(true)
            }label: {
                HStack {
                    Text("Don't have an account?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.blue)
                        
                    
                    Text("Sign Up")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.blue)
                    
                }
                
            }
            .padding(.bottom,32)
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        
        
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthenticationViewModel())
}
