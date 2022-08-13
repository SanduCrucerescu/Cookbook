//
//  RecipePage.swift
//  Cookbook
//
//  Created by Alex on 2022-08-13.
//

import SwiftUI

struct RecipePage: View {
    private(set) var recipe: Recipe

    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false) {
                CachedAsyncImage(url: URL(string: recipe.image), urlCache: .imageCache) { phase in
                    if let image = phase.image{
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .ignoresSafeArea(.all, edges: .top)
                    } else {
                        ProgressView()
//                            .frame(width: DrawingConstants.imageWidth,
//                                   height: DrawingConstants.imageHeight * (210/210))
                    }
                }
//                Image("köttbullar")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .ignoresSafeArea(.all, edges: .top)
                
                contents(recipe: recipe)
            }
            .edgesIgnoringSafeArea(.top)
        }
        .background(Color.backgroundColor)
//        .navigationBarTitle(Text(""),
//                            displayMode: .inline)
    }
}

struct contents: View {
    var recipe: Recipe
    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.title)
                .font(.custom("Welland",
                              size: 30))
                .foregroundColor(.lightBlack)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tincidunt ex vel velit malesuada venenatis. Morbi volutpat luctus metus, quis laoreet magna pellentesque in. Donec tristique porttitor bibendum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec quis felis nisl. Cras tellus turpis, commodo a arcu eget, faucibus tempor dolor. Cras at metus dignissim, molestie ante vel, lobortis felis. Sed tempor quam nibh, ultrices imperdiet quam aliquet a. Curabitur sed congue diam. Sed ut eleifend ipsum, a scelerisque nisl. Aenean egestas consectetur quam, in porttitor sem posuere id. ")
                .font(.custom("Welland",
                              size: 18))
                .foregroundColor(.lightBlack)
            
            Button {
                print(recipe)
            } label: {
                Text("click")
            }

            HStack{
                VStack{
                    Text("Ingredients")
                        .font(.custom("Welland",
                                      size: 15))
                        .foregroundColor(.lightBlack)
                    
                }
                Spacer()
                VStack{
                    Text("Description")
                        .font(.custom("Welland",
                                      size: 15))
                        .foregroundColor(.lightBlack)
                }
            }
        }
        .padding()
        .background(Color.backgroundColor)
        .cornerRadius(10)
        .edgesIgnoringSafeArea(.bottom)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .offset(x: 0, y: -30.0)
    }
}



struct RecipePage_Previews: PreviewProvider {
    static var previews: some View {
        RecipePage(recipe: Recipe(id: "", title: "", description: "", author: "", image: "", ingredients: [Ingredient](), directions: [Direction](), prepTime: 0))
    }
}
