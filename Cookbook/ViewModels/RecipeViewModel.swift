//
//  RecipeViewModel.swift
//  Cookbook
//
//  Created by Alex on 2022-08-02.
//

import Foundation

class recipeViewModel: ObservableObject {
    //typealias Recipe = recipeModel.Recipe
    @Published private(set) var recipe: recipeModel = createRecipes()
    
    var recipes:Array<Recipe> = []
    
    private static func createRecipes() -> recipeModel {
        recipeModel()
    }
    
    
}
