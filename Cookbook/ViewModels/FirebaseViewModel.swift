//
//  FirebaseViewModel.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseStorage
import FirebaseFirestoreSwift
import UIKit

@MainActor class FirebaseViewModel: ObservableObject {
    @Published private(set) var isLogedIn: Bool = true
    @Published private(set) var registerSuccessfull: Bool?
    @Published private(set) var passwordsAreNotEqual: Bool = false
    @Published private(set) var isEmail:Bool = true
    private(set) var image: UIImage?

    private var auth = Auth.auth()
    private var db = Firestore.firestore()
    private var storageRef = Storage.storage().reference()
    
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
        //var image: UIImage?
        
        db.collection("Recipes").addSnapshotListener { snapshot, error in
            if error == nil {
                if let shapshot = snapshot {
                    
                    for recipe in snapshot!.documents {
 
                    
                   //recipe DispatchQueue.main.async {
                        self.recipeViewModel.recipes = snapshot?.documents.map({ data in
                            var image: UIImage?
                            Task{
                                await self.getPhoto(data["imageURL"] as? String ?? "")
                            }
                                return Recipe(id: data.documentID,
                                              title: data["Title"] as? String ?? "",
                                              description: data["Desctiprion"] as? String ?? "",
                                              author: data["Author"] as? String ?? "",
                                              image: image!)

                        }) ?? []
                        print(self.recipeViewModel.recipes)
                    //}
                    }
                } else {
                    print("no data")
                }
            }
        }
    }
    
    //MARK: - Upload image to db
    
    func uploadImage(_ image: UIImage?) {
        guard image != nil else { return }
    
        let imageData = image!.jpegData(compressionQuality: 0.8)
        
        guard imageData != nil else { return }
        
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil { 
                self.db.collection("Recipes").document().setData(
                    ["image": path]
                )
            }
        }
    }
    
    //MARK: - Get photo from db
    
    func getPhoto(_ path: String) async -> UIImage {
        let fileRef = self.storageRef.child(path)
        var image = UIImage(systemName: "plus")
        await fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if error == nil && data != nil {
                print("yes")
                DispatchQueue.main.async {
                    let image = UIImage(data: data!)
                    print("s")
                }
            }
        }
        return image!
    }
}
