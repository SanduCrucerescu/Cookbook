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
    var ingredient: Ingredient?
    @Binding var ingredients: Array<Ingredient>
    
    
    var body: some View {
        HStack{
            TextField("Ingredient", text: $text)
                .textFieldStyle(TextFieldDesign(image: "text.alignleft",
                                                error: false,
                                                shadow: false))
                .onChange(of: text) { newValue in
                    text = newValue
//                    if index != 0 {
//                        index = ingredients.firstIndex(where: {$0.id == ingredient?.id})
//                    }
                    //let indexIsValid = ingredients.indices.contains(index)
                    print(text)
                    print(index)
                    
//                    if index == 0 {
//                        ingredients[0].description = newValue
//                    }
//
                    if index == 0 {
                        ingredients[index] = Ingredient(description: newValue)
                    } else {
                        if ingredients.indices.contains(index) {
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
                    
                    let inde = ingredients.firstIndex(where: {$0.id == ingredient!.id})
                   //                    guard ingredients.count != 0 else { return }
                   if ingredients.count != 1 {
                       ingredients.remove(at: inde!)
                   }
//                    guard ingredients.count != 0 else { return }
//                if ingredients.count != 1 {
//                    ingredients.remove(at: inde!)
//                }
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
}

