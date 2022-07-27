//
//  FirebaseModel.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

//Not in use

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

struct FirebaseModel {
    private(set) var isLogedIn: Bool?
    private(set) var registerSuccessfull: Bool?
    private(set) var shouldShake: Bool = false

    private var auth = Auth.auth()
    private var firestore = Firestore.firestore()
    
    
    // MARK: - SignIn
    
    func signIn(_ email: String, _ passwordProvided: String, _ viewRouter: ViewRouter) {
         auth.signIn(withEmail: email, password: passwordProvided) { result, error in
            guard result != nil, error == nil else {
                print("false")
                return
            }
//            self.changeLogedInStatus()
                print("true")
                viewRouter.page = .MainPage
        }
        
    }

    
    // MARK: - Register
    
    func register(_ email: String, _ password1: String, _ password2: String, _ username: String) {
        guard passwordsCheck(password1, password2) else {
           // self.shouldShake = true
            print(self.shouldShake)
            return
        }
        auth.createUser(withEmail: email, password: password1) { (result, error) in
            guard result != nil, error == nil else {
               // self.registerSuccessfull = false
                print("false")
                return
            }
            //self.registerSuccessfull = true
            guard let uid:String =  Auth.auth().currentUser?.uid else { return }

            self.firestore.collection("Users").document(uid).setData(["Username": username])


            print("true")
        }

    }
    
    //MARK: - Check if the passwords are the same
    
    func passwordsCheck(_ passowrd1: String, _ password2: String) -> Bool {
        passowrd1.elementsEqual(password2)
    }
}
    


