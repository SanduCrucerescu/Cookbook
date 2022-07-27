//
//  FirebaseModel.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import Foundation
import FirebaseAuth

class FirebaseModel {
    private(set) var isLogedIn: Bool?
    private(set) var registerSuccessfull: Bool?
    
    // MARK: - SignIn
    
    func signIn(_ email: String, _ passwordProvided: String, _ viewRouter: ViewRouter) {
        Auth.auth().signIn(withEmail: email, password: passwordProvided) { result, error in
            guard result != nil, error == nil else {
                self.isLogedIn = false
                print("false")
                return
            }
                self.isLogedIn = true
                print("true")
                viewRouter.page = .MainPage
        }
    }
    
    // MARK: - Register
    
    func register(_ email: String, _ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                self.registerSuccessfull = false
                print("false")
                return
            }
            self.registerSuccessfull = true
            print("true")
        }
    }
}
    


