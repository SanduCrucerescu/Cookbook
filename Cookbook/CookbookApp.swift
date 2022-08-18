//
//  CookbookApp.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI
import Firebase

@main
struct CookbookApp: App {
    @ObservedObject var recipeViewModel: RecipeViewModel
    @ObservedObject var firebase: FirebaseViewModel
        
    init() {
        FirebaseApp.configure()
        let b = RecipeViewModel()
        let a = FirebaseViewModel(recipeViewModel: b)
        self.firebase = a
        self.recipeViewModel = b
    
    }
    
    var body: some Scene {
        WindowGroup {
            //CreateRecipeView()
            //LoginView()
            RecipePage(recipe: Recipe(
                title: "",
                description: "",
                author: "",
                image: "",
                ingredients: [Ingredient](),
                directions: [Direction](),
                prepTime: 0,
                comments: [Comment(text: "testdsdsdsfsdffdfdsfds", author: "Author",
                                   replies: [Comment(text: "subcommnet", author: "123"),
                                             Comment(text: "subcommnet1", author: "123"),
                                             Comment(text: "subcommnet2", author: "123")]),
                                                    
                           Comment(text: "test1233", author: "Author2",
                                   replies: [Comment(text: "subcommnet", author: "1233"),
                                             Comment(text: "subcommnet", author: "123"),
                                             Comment(text: "subcommnet", author: "123")])])
            )
                .environmentObject(firebase)
                .environmentObject(recipeViewModel)
        }
    }
}
