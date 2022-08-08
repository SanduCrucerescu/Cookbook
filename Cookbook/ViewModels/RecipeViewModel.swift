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

    func addRecipe() {
        firebase.uploadDirection(<#T##direction: Array<Direction>##Array<Direction>#>, <#T##uid: String##String#>)
    }
    
    
    
    
    
    
    
}
