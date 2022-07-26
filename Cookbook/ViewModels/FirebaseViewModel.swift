//
//  FirebaseViewModel.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import Foundation


class FirebaseViewModel {
    private(set) var firebaseModel:FirebaseModel = createFirebaseModel()
    
    private static func createFirebaseModel() -> FirebaseModel {
        FirebaseModel()
    }
    
    func logIn(_ email: String, _ password: String,  _ viewRouter: ViewRouter) {
        firebaseModel.signIn(email, password, viewRouter)
    }
    
}
