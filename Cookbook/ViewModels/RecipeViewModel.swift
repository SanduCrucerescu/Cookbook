//
//  RecipeViewModel.swift
//  Cookbook
//
//  Created by Alex on 2022-08-02.
//

import Foundation
import UIKit

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var showPicker: Bool = false
    @Published var image: UIImage?
    @Published var retrivedImage: UIImage?
    @Published var title: String = ""
    @Published var description: String = ""
    
    @Published var ingredients: Array<Ingredient> = [Ingredient(description: "")]
    @Published var directions: Array<Direction> = [Direction(direction: "sas")]
    @Published var dateNow = ""
    @Published var showPiker = false
    
    
    @Published var recipes:Array<Recipe> = []
    
    var firebase: FirebaseViewModel = FirebaseViewModel()

    func addRecipe() async {
        let directionsDictionary =  directions.reduce([String: Any]()) { (dict, direction) -> [String: Any]  in
           // var number = 1
            var dict = dict
            dict["Direction \(direction.id)"] = direction.direction
            return dict
        }
        
        let ingredientsDictionary = ingredients.reduce([String: Any]()) { (dict, ingredient) -> [String: Any] in
            var dict = dict
            dict["Ingredient \(ingredient.id)"] = ingredient.description
            return dict
            
        }
        
        await firebase.uploadRecipe(title, description, UUID().uuidString, image!, ingredientsDictionary, directionsDictionary)
    }
}
