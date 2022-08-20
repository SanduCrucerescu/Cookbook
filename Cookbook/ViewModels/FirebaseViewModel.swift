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

class FirebaseViewModel: ObservableObject {
    @Published private(set) var isLogedIn: Bool?
    @Published private(set) var registerSuccessfull: Bool?
    @Published private(set) var passwordsAreNotEqual: Bool = false
    @Published private(set) var isEmail:Bool = true
    
    private var auth = Auth.auth()
    private var db = Firestore.firestore()
    private var storageRef = Storage.storage().reference()
    
    @Published private var recipes: Array<Recipe> = []
    
    var recipeViewModel: RecipeViewModel?
    
    init(recipeViewModel: RecipeViewModel?=nil) {
        self.recipeViewModel = recipeViewModel
    }
    
    
    func getRecipes() -> Array<Recipe> {
        recipes
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
    @MainActor
    func signIn(_ email: String, _ passwordProvided: String) async -> Void {
        do {
            let authDataResults = try await auth.signIn(withEmail: email, password: passwordProvided)
            
            _ = authDataResults.user
            
            self.isLogedIn = true
            
            self.getData()
            
        } catch {
            self.isLogedIn = false
            print(error)
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
        DispatchQueue.global(qos: .utility).async {
            self.db.collection("Recipes").addSnapshotListener { snapshot, error in
                DispatchQueue.main.async {
                    
                    for data in snapshot!.documents {
                        let id = data.documentID
                        let title = data["Title"] as? String ?? ""
                        let description = data["Description"] as? String ?? ""
                        let author = data["Author"] as? String ?? ""
                        let image = data["imageURL"] as? String ?? ""
                        let ingredients =  data["Ingredients"] as? [String: String] ?? [:]
                        let directions = data["Directions"] as? [String: String] ?? [:]
                        let prepTime = data["PrepTime"] as? Int ?? 0
                        let comments = data["Comments"] as? [String: [String: Any]] ?? [:]


                        //Converting firebase map to array
                        let ingredientsArray: [Ingredient] = ingredients.map { Ingredient(id: $0.key,description: $0.value)}
                        let directionsArray: [Direction] = directions.map { Direction(id: $0.key, direction: $0.value) }
                        let comentsArray: [Comment] = comments.map{ comment in

                            let repliesDict = comment.value["replies"] as? [String: [String: Any]] ?? [:]

                            let repliesArray: [Comment] = repliesDict.map { replies in
                                return Comment(text: replies.value["text"] as? String ?? "",
                                               author: replies.value["author"] as? String ?? "")
                            }

                            return Comment(id: comment.key,
                                           text: comment.value["text"] as! String ,
                                           author: comment.value["author"] as! String,
                                           replies: repliesArray)
                        }
                        self.getPhoto(url: image) { status, image in
                
                            self.recipeViewModel?.recipes.append(Recipe(id: id,
                                              title: title,
                                              description: description,
                                              author: author,
                                              image: image,
                                              ingredients: ingredientsArray,
                                              directions: directionsArray,
                                              prepTime: prepTime,
                                              comments: comentsArray))
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Upload recipe
    
    func uploadRecipe(_ title: String, _ description: String, _ author: String, _ image: UIImage, _ ingredients: [String: Any], _ directions: [String: Any]) async {
        await self.uploadImage(image) { status, response in
            self.db.collection("Recipes").document(UUID().uuidString).setData(["Author": author,
                                                                               "Title": title,
                                                                               "Description": description,
                                                                               "imageURL": response,
                                                                               "Ingredients": ingredients,
                                                                               "Directions": directions])
        }
    }
    
    
    
    //MARK: - Upload image to db
    
    func uploadImage(_ image: UIImage?, completion: @escaping(_ status: Bool, _ response: String) -> Void) async {
        //guard image != nil else { return }
        
        let imageData = image!.jpegData(compressionQuality: 0.8)
        
        
        //guard imageData != nil else { return }
        
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        let docID = UUID().uuidString
        
        let _ = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil && metadata != nil {
                self.db.collection("images").document(docID).setData(["url" : path])
                completion(true, docID)
//                fileRef.downloadURL { url, error in
//                    if error == nil && url != nil {
//                        //print(url?.absoluteString ?? "No URL")
//                        completion(true, url?.absoluteString ?? "No URL")
//                    }
//                }
                //self.db.collection("Recipes").document().setData(["image": path])
            }
        }
    }
    
    //MARK: - Get Photos
    func getPhoto(url: String, completion: @escaping (_ finished: Bool, _ image: UIImage) -> Void)  {
        DispatchQueue.global(qos: .userInitiated).async {
            self.db.collection("images").document(url).getDocument { snapshot, error in
                 if error == nil && snapshot != nil {
                     let fileRef = self.storageRef.child(snapshot!["url"] as! String)

                      fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                         if error == nil && data != nil {
                             print("yes")
                             DispatchQueue.main.async {
                                 completion(true, UIImage(data: data!)!)
                             }
                         }
                     }
    //                 }
                 }
             }
        }
    }

    
    //MARK: - Add Comment
    
    func addComment(_ recipe: Recipe) {
        //let commentDict = comment.conveertToDict()
        //recipe.comments.append(comment)
        
        let commentDict = recipe.comments.reduce([String: Any]()) { (dict, comment) -> [String: Any]  in
            // var number = 1
            var dict = dict
            let comment1 = comment.conveertToDict()
            dict[comment.id] = comment1
            return dict
         }
        
        //print(commentDict)
        
        db.collection("Recipes").document(recipe.id).updateData(["Comments": commentDict])
    }
}
