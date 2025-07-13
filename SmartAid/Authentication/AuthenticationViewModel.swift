//
//  AuthenticationViewModel.swift
//  SmartAid
//
//  Created by mohdanas on 01/07/25.
//
import Foundation
import FirebaseAuth

class AuthenticationViewModel:ObservableObject {
    @Published var user :User?
    @Published var isLoggedIn:Bool = false
    @Published var errorMessage :String = ""
    @Published var isLoading:Bool = false
    
    init(){
        self.user = Auth.auth().currentUser
        self.isLoggedIn = user != nil
    }
    
    
    func signUp(email:String,password:String,name:String){
        guard !email.isEmpty, !password.isEmpty,!name.isEmpty else {
            self.errorMessage = "Please fill all the required fields"
            return
        }
        self.isLoading = true
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] result,error in
            DispatchQueue.main.async{
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
                    return
                }
                self?.user = result?.user
                self?.isLoggedIn = true
            }
            
        }
    }
    
    
    func signIn(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            self.errorMessage = "Please fill all the required fields"
            return
        }
        self.isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async{
                self?.isLoading = false
                if let error = error {
                    self?.errorMessage = "Please fill correct details"
                    print(error.localizedDescription)
                    return
                }
                self?.user = result?.user
                self?.isLoggedIn = true
            }
            
        }
    }
    
    func signOut() {
           do {
               try Auth.auth().signOut()
               self.user = nil
               self.isLoggedIn = false
           } catch {
               self.errorMessage = error.localizedDescription
           }
       }
    
    func clearError() {
            self.errorMessage = ""
        }

}
