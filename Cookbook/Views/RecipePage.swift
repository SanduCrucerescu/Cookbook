//
//  RecipePage.swift
//  Cookbook
//
//  Created by Alex on 2022-08-13.
//

import SwiftUI

struct RecipePage: View {
    private(set) var recipe: Recipe
    @EnvironmentObject var firebase: FirebaseViewModel

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
                
                contents(recipe: recipe,
                         firebase: firebase)
                CommentsSection(recipe: recipe,
                                firebase: firebase)
                
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
    var firebase: FirebaseViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.title)
                .font(.custom("Welland",
                              size: 30))
                .foregroundColor(.lightBlack)
            Text("Author: \(recipe.author)")
                .font(.custom("Welland Light",
                               size: 15))
                 .foregroundColor(.lightBlack)
            Text(recipe.description)
                .font(.custom("Welland",
                              size: 18))
                .foregroundColor(.lightBlack)
            Spacer()
            Text("Ingredients")
                .font(.custom("Welland",
                              size: 20))
                .foregroundColor(.sageGreen)
            ForEach(recipe.ingredients) { ingredient in
                Text(ingredient.description)
                    .font(.custom("Welland",
                                  size: 18))
                    .foregroundColor(.lightBlack)
            }
                
            
            Spacer()

            Text("Description")
                .font(.custom("Welland",
                              size: 20))
                .foregroundColor(.sageGreen)
            ForEach(recipe.directions) { direction in
                Text(direction.direction)
                    .font(.custom("Welland",
                                  size: 18))
                    .foregroundColor(.lightBlack)
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

struct CommentsSection: View {
    @State var recipe: Recipe
    var firebase: FirebaseViewModel
    @State var text = ""
    
    var body: some View {
        VStack {
            ForEach(recipe.comments) { comment in
                Text(comment.text)
            }
            
            TextField("Comment", text: $text)
                .textFieldStyle(TextFieldDesign(image: "text.bubble",
                                                error: false,
                                                shadow: false))
            
            Button {
                self.recipe.comments.append(Comment(text: text, author: "text"))
                firebase.addComment(recipe)
            } label: {
                Text("Add Comment")
            }
            .buttonStyle(CustomButton(color: .white))

            
        }
    }
}




struct RecipePage_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeViewModel()
        let firebase = FirebaseViewModel(recipeViewModel: recipe)
        RecipePage(recipe: Recipe(title: "", description: "", author: "", image: "", ingredients: [Ingredient](), directions: [Direction](), prepTime: 0, comments: [Comment]()))
            .environmentObject(firebase)
    }
}
