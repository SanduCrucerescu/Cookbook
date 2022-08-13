//
//  IngredientTextField.swift
//  Cookbook
//
//  Created by Alex on 2022-08-08.
//

import SwiftUI
import Combine


struct IngredientTextField: View {
    @State var text = ""
    @State var index: Int
    @State var ingredient: Ingredient
    @Binding var ingredients: Array<Ingredient>
    
    
    var body: some View {
        HStack{
            TextField("Ingredient", text: $ingredient.description)
                .textFieldStyle(TextFieldDesign(image: "text.alignleft",
                                                error: false,
                                                shadow: false))
                .onChange(of: ingredient.description) { newValue in
                    let indexIsValid = ingredients.indices.contains(index)

                    if indexIsValid {

                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            ingredients[index] = ingredient
                        }
                    }
                }
            
            
            Image(systemName: "minus.circle")
                .font(.title)
                .foregroundColor(.sageGreen)
                .onTapGesture {
                    
                let inde = ingredients.firstIndex(where: {$0.id == ingredient.id})

                guard ingredients.count != 1 else { return }
                ingredients.remove(at: inde!)
            }
                
            Image(systemName: "plus.circle")
                .font(.title)
                .foregroundColor(.sageGreen)
                .onTapGesture {
                    ingredients.append(Ingredient(description: ""))
                    print(ingredients)
                }
                
        }
    }
}

