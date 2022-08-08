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
            AddingRecipeView()
            //LoginView()
                .environmentObject(firebase)
                .environmentObject(recipeViewModel)
        }
    }
}
