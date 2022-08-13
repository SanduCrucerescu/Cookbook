//
//  DirectionsTextField.swift
//  Cookbook
//
//  Created by Alex on 2022-08-08.
//

import SwiftUI

struct DirectionsTextField: View {
    var index: Int
    @State var direction: Direction
    @Binding var directions: Array<Direction>
    
    var body: some View {
        HStack{
//            TextField("Direction", text: $direction, axis: .vertical)
//                .lineLimit(3, reservesSpace: true)
//                .textFieldStyle(TextFieldDesign(image: "text.alignleft",
//                                                error: false,
//                                                shadow: false,
//                                                height: 80))
            TextField("Direction", text: $direction.direction)
                .textFieldStyle(TextFieldDesign(image: "text.alignleft",
                                                error: false,
                                                shadow: false,
                                                height: 80))
            
                .onChange(of: direction.direction) { newValue in
                    let indexIsValid = directions.indices.contains(index)
  
                    if indexIsValid {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            directions[index] = direction
                        }
                    }
                }
            
            
            Image(systemName: "minus.circle")
                .font(.title)
                .foregroundColor(.sageGreen)
                .onTapGesture {
                    let inde = directions.firstIndex(where: {$0.id == direction.id})
                    guard directions.count != 1 else { return }
                    directions.remove(at: inde!)
                    
            }
                
            Image(systemName: "plus.circle")
                .font(.title)
                .foregroundColor(.sageGreen)
                .onTapGesture {
                    directions.append(Direction(direction: ""))
                }
        }
    }
}
