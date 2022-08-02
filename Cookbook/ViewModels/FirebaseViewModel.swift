//
//  FirebaseViewModel.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

class FirebaseViewModel: ObservableObject {
    @Published private(set) var isLogedIn: Bool = true
    @Published private(set) var registerSuccessfull: Bool?
    @Published private(set) var passwordsAreNotEqual: Bool = false
    @Published private(set) var isEmail:Bool = true

    private var auth = Auth.auth()
    private var db = Firestore.firestore()
    var recipeViewModel: RecipeViewModel
    
    
    init(recipeViewModel: RecipeViewModel) {
        self.recipeViewModel = recipeViewModel
    }
    
    //MARK: - Check if the passwords are the same
    
    func passwordsCheck(_ passowrd1: String, _ password2: String) -> Bool {
        passowrd1.elementsEqual(password2)
    }
    
    //MARK: - Checks if it is a valid email
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // MARK: - SignIn
    
    func signIn(_ email: String, _ passwordProvided: String, _ viewRouter: ViewRouter) {
         auth.signIn(withEmail: email, password: passwordProvided) { result, error in
            guard result != nil, error == nil else {
                self.isLogedIn = false
                print("false")
                return
            }
             self.isLogedIn = true
                print("true")
             self.getData()
             print(self.recipeViewModel.recipes)
             viewRouter.page = .MainPage
        }        
    }

    
    // MARK: - Register
    
    func register(_ email: String, _ password1: String, _ password2: String, _ username: String) {
//        guard isValidEmail(email) else {
//            self.isEmail.toggle()
//            print("false email")
//            return
//        }
        if isValidEmail(email){
            self.isEmail = true
        } else {
            self.isEmail = false
        }
        guard passwordsCheck(password1, password2) else {
            self.passwordsAreNotEqual = true
            print(self.passwordsAreNotEqual)
            return
        }
        self.passwordsAreNotEqual = false
        auth.createUser(withEmail: email, password: password1) { (result, error) in
            guard result != nil, error == nil else {
                self.registerSuccessfull = false
                print("false")
                return
            }
            self.registerSuccessfull = true
            guard let uid:String =  Auth.auth().currentUser?.uid else { return }

            self.db.collection("Users").document(uid).setData(["Username": username])


            print("true")
        }
    }
    
    //MARK: - Get data from firebase
    
    func getData() {
        
        db.collection("Recipes").addSnapshotListener { snapshot, error in
            if error == nil {
                if let shapshot = snapshot {
                    DispatchQueue.main.async {
                        self.recipeViewModel.recipes =  snapshot?.documents.map({ data in
                            return Recipe(id: data.documentID,
                                          title: data["Title"] as? String ?? "",
                                          description: data["Desctiprion"] as? String ?? "",
                                          author: data["Author"] as? String ?? "")
                        }) ?? []
                        print(self.recipeViewModel.recipes)
                    }
                }
            } else {
                print("no data")
            }
        }
    }
}
