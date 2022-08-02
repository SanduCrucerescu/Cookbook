//
//  RecipeModel.swift
//  Cookbook
//
//  Created by Alex on 2022-08-02.
//

import Foundation

struct recipeModel  {
//    struct Recipe: Identifiable {
//        var id: String
//        var title: String
//        var description: String
//        var author: String
//    }

    private(set) var recipes: Array<Recipe> = []


//    init() {
//        recipes = []
//
//
//    }



}

struct Recipe: Identifiable {
    var id: String
    var title: String
    var description: String
    var author: String
}

