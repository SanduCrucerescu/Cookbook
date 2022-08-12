//
//  DirectionsTextField.swift
//  Cookbook
//
//  Created by Alex on 2022-08-08.
//

import SwiftUI

struct DirectionsTextField: View {
    @State var text = ""
    var index: Int
    @Binding var directions: Array<Direction>
    
    var body: some View {
        HStack{
//            TextField("Direction", text: $direction, axis: .vertical)
//                .lineLimit(3, reservesSpace: true)
//                .textFieldStyle(TextFieldDesign(image: "text.alignleft",
//                                                error: false,
//                                                shadow: false,
//                                                height: 80))
            TextField("Direction", text: $text)
                .textFieldStyle(TextFieldDesign(image: "text.alignleft",
                                                error: false,
                                                shadow: false,
                                                height: 80))
                .onChange(of: text) { newValue in
                    if index == 0 {
                        directions[index] = Direction(direction: newValue)
                    } else {
                        if directions.indices.contains(index) {
                            directions[index] = Direction(direction: newValue)

                        } else {
                            directions.append(Direction(direction: newValue))
                        }
                    }
                }
            
            
            Image(systemName: "minus.circle")
                .font(.title)
                .foregroundColor(.sageGreen)
                .onTapGesture {
                    //let index = directions.firstIndex(where: {$0.id == id})
//                    guard directions.count == 1 else { return }
//                    print(directions.count)
                    if directions.count != 1 {
                        directions.remove(at: index)
                    }
            }
                
//            Image(systemName: "plus.circle")
//                .font(.title)
//                .foregroundColor(.sageGreen)
//                .onTapGesture {
//                    directions.append(Direction(direction: direction))
//                   // print(ingredients)
//                
//            }
        }
    }
}
