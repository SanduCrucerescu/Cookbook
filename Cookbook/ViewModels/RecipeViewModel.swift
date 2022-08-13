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
    @Published var ingredients: Array<Ingredient> = [Ingredient(description: ""), Ingredient(description: ""), Ingredient(description: "")]
    @Published var directions: Array<Direction> = [Direction(direction: ""), Direction(direction: ""), Direction(direction: "")]
    @Published var prepTime = ""
    @Published var emptyTitle = false
    @Published var emptyDescription = false
    @Published var emptyImage = false
    @Published var emptyPrepTime = false
    
    
    @Published var recipes:Array<Recipe> = []
    
    var firebase: FirebaseViewModel = FirebaseViewModel()

    func addRecipe() async {
                
        guard !title.isEmpty || !description.isEmpty || !prepTime.isEmpty else {
            emptyTitle = title.isEmpty ? true : false
            emptyDescription = description.isEmpty ? true : false
            emptyPrepTime = prepTime.isEmpty ? true : false
            
            return
        }
        
//        guard !description.isEmpty else { emptyDescription = true; return}

        print(emptyTitle)


//        let directionsDictionary =  directions.reduce([String: Any]()) { (dict, direction) -> [String: Any]  in
//           // var number = 1
//            var dict = dict
//            dict["Direction \(direction.id)"] = direction.direction
//            return dict
//        }
//
//        let ingredientsDictionary = ingredients.reduce([String: Any]()) { (dict, ingredient) -> [String: Any] in
//            var dict = dict
//            dict["Ingredient \(ingredient.id)"] = ingredient.description
//            return dict
//
//        }
//
//        await firebase.uploadRecipe(title, description, UUID().uuidString, image!, ingredientsDictionary, directionsDictionary)
    }
}
