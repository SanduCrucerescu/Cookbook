//
//  DirectionsTextField.swift
//  Cookbook
//
//  Created by Alex on 2022-08-08.
//

import SwiftUI

struct DirectionsTextField: View {
    @State var direction = ""
    var dir: Direction
    @Binding var directions: Array<Direction>
    
    var body: some View {
        HStack{
            TextField("Direction", text: $direction)
                .textFieldStyle(TextFieldDesign(image: "text.alignleft", error: false, shadow: false))
                .lineLimit(3)
            Image(systemName: "minus.circle")
                .font(.title)
                .foregroundColor(.sageGreen)
                .onTapGesture {
                    let index = directions.firstIndex(where: {$0.id == dir.id})
                    guard direction.count != 0 else { return }
                    directions.remove(at: index!)
            }
                
            Image(systemName: "plus.circle")
                .font(.title)
                .foregroundColor(.sageGreen)
                .onTapGesture {
                    directions.append(Direction(direction: direction))
                   // print(ingredients)
                
            }
        }
    }
}
