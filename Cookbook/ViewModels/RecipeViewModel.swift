//
//  RecipeViewModel.swift
//  Cookbook
//
//  Created by Alex on 2022-08-02.
//

import Foundation
import UIKit

//@MainActor
class RecipeViewModel: ObservableObject {
    @Published var showPicker: Bool = false
    @Published var image: UIImage?
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var ingredients: Array<Ingredient> = [Ingredient(description: ""), Ingredient(description: ""), Ingredient(description: "")]
    @Published var directions: Array<Direction> = [Direction(direction: ""), Direction(direction: ""), Direction(direction: "")]
    @Published var prepTime = ""
    @Published var emptyTitle = false
    @Published var emptyDescription = false
    @Published var emptyImage = false
    @Published var emptyPrepTime = false
    @Published var emptyImageField = false
    
    
    @Published var recipes:Array<Recipe> = []
    
    var firebase: FirebaseViewModel = FirebaseViewModel()

    func addRecipe() async {
        print("1")
        
        guard !title.isEmpty && !description.isEmpty && !prepTime.isEmpty && image != nil else {
            emptyTitle = title.isEmpty ? true : false
            emptyDescription = description.isEmpty ? true : false
            emptyPrepTime = prepTime.isEmpty ? true : false
            emptyImage = image == nil ? true : false
            
            return
        }
        print("2")
        
        let directionsDictionary =  directions.reduce([String: Any]()) { (dict, direction) -> [String: Any]  in
            var dict = dict
            dict[direction.id] = direction.direction
            return dict
        }

        let ingredientsDictionary = ingredients.reduce([String: Any]()) { (dict, ingredient) -> [String: Any] in
            var dict = dict
            dict[ingredient.id] = ingredient.description
            return dict

        }

        print("here")
        await firebase.uploadRecipe(title, description, "Alez", image!, ingredientsDictionary, directionsDictionary)
    }
}
