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
    @StateObject var recipeViewModel: RecipeViewModel
    @StateObject var firebase: FirebaseViewModel
        
    init() {
        FirebaseApp.configure()
        self._recipeViewModel = StateObject(wrappedValue: RecipeViewModel())
        self._firebase = StateObject(wrappedValue: FirebaseViewModel(recipeViewModel: RecipeViewModel())) //TODO: fix the init
        
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(firebase)
        }
    }
}
