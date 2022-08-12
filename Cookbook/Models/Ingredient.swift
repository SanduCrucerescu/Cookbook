//
//  Ingredient.swift
//  Cookbook
//
//  Created by Alex on 2022-08-08.
//

import Foundation

struct Ingredient: Identifiable, Hashable {
    var id = UUID()
    var description: String
}
