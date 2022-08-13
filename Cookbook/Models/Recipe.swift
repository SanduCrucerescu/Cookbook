//
//  RecipeModel.swift
//  Cookbook
//
//  Created by Alex on 2022-08-02.
//

import Foundation
import UIKit

struct Recipe: Identifiable, Codable {
    var id: String
    var title: String
    var description: String
    var author: String
    var image: String
    var ingredients: Array<Ingredient>
    var directions: Array<Direction>
    var prepTime: Int
}

