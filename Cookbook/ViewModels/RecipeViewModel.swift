//
//  RecipeViewModel.swift
//  Cookbook
//
//  Created by Alex on 2022-08-02.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes:Array<Recipe> = []
    
    var firebase: FirebaseViewModel = FirebaseViewModel()

    func addRecipe(_ directions: Array<Direction>) {
        firebase.uploadDirection(directions, "test")
    }
    
    
    
    
    
    
    
}
