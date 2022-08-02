//
//  RecipeViewModel.swift
//  Cookbook
//
//  Created by Alex on 2022-08-02.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes:Array<Recipe> = []
    
}
