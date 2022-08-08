//
//  IngredientTextField.swift
//  Cookbook
//
//  Created by Alex on 2022-08-08.
//

import SwiftUI

struct IngredientTextField: View {
    @State var ingredient = ""
    var i: Ingredient
    @Binding var ingredients: Array<Ingredient>
    
    var body: some View {
        HStack{
            TextField("Ingredient", text: $ingredient)
                .textFieldStyle(TextFieldDesign(image: "text.alignleft", error: false, shadow: false))
            Image(systemName: "minus.circle")
                .font(.title)
                .foregroundColor(.sageGreen)
                .onTapGesture {
                    let index = ingredients.firstIndex(where: {$0.id == i.id})
                    guard index != 0 else { return }
                    ingredients.remove(at: index!)
            }
                
            Image(systemName: "plus.circle")
                .font(.title)
                .foregroundColor(.sageGreen)
                .onTapGesture {
                    ingredients.append(Ingredient(description: ingredient))
                    print(ingredients)
                
            }
        }
    }
}
