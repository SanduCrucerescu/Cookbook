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
    var index: Int
    @Binding var ingredients: Array<Ingredient>
    
    var body: some View {
        HStack{
            TextField("Ingredient", text: $text)
                .textFieldStyle(TextFieldDesign(image: "text.alignleft",
                                                error: false,
                                                shadow: false))
                .onChange(of: text) { newValue in
                    
                    let indexIsValid = ingredients.indices.contains(index)
                    print(text)
                    print(newValue)
                    
                    if indexIsValid {
                        ingredients[index] = Ingredient(description: newValue)

                    } else {
                        ingredients.append(Ingredient(description: newValue))
                    }
                    
                }
              }
            Image(systemName: "minus.circle")
                .font(.title)
                .foregroundColor(.sageGreen)
                .onTapGesture {
                    
                    //ingredients.remove(at: index)
                    
//                    let inde = ingredients.firstIndex(where: {$0.id == index.id})
////                    guard ingredients.count != 0 else { return }
//                    if ingredients.count != 1 {
//                        ingredients.remove(at: inde!)
//                    }
            }
                
            Image(systemName: "plus.circle")
                .font(.title)
                .foregroundColor(.sageGreen)
                .onTapGesture {
                    //ingredients.append(Ingredient(description: ingredient))
                    print(ingredients)
                
        }
    }
}

