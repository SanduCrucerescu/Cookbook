//
//  RecipeBox.swift
//  Cookbook
//
//  Created by Alex on 2022-08-08.
//

import SwiftUI

struct RecipeBox: View {
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let imageWidth: CGFloat = 210
        static let imageHeight: CGFloat = 200
        static let textSize: CGFloat = 20
        static let frameWidth: CGFloat = 210
    }
    
    private(set) var recipe: Recipe
    
    var body: some View {
        NavigationLink {
            RecipePage(recipe)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                    .fill(.white)
                VStack(alignment: .leading){
                    if recipe.image != nil {
                        Image(uiImage: recipe.image!)
                            .resizable()
                                .frame(width: DrawingConstants.imageWidth,
                                       height: DrawingConstants.imageHeight * (210/210))
                                .cornerRadius(DrawingConstants.cornerRadius)
                    } else {
                        ProgressView()
                            .frame(width: DrawingConstants.imageWidth,
                                   height: DrawingConstants.imageHeight * (210/210))
                    }
                        
                    Text(recipe.title)
                        .font(.custom("ProximaNova-Regular",
                                      size: DrawingConstants.textSize))
                        .foregroundColor(.textColor)
                    Spacer()
                    HStack(spacing: 2) {
                        ForEach(0 ..< 5) { item in
                            Image(systemName: "star")
                                .foregroundColor(.textColor)
                        }
                        Spacer()
                    Text("$1299")
                        .font(.custom("Welland Bold",
                                      size: DrawingConstants.textSize))
                        .foregroundColor(.textColor)
                        
                    }
                }
            }
            .frame(width: DrawingConstants.frameWidth)
            .padding()
            .background(.white)
            .cornerRadius(DrawingConstants.cornerRadius)
        }
    }
}
