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
    @ObservedObject var recipePageVM = RecipePageViewModel()
    
    
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
                    }
                }
                contents(recipe: recipe,
                         firebase: firebase)
                CommentsSection(recipe: recipe,
                                firebase: firebase,
                                recipePageVM: recipePageVM)
                
            }
            .edgesIgnoringSafeArea(.top)
        }
        .background(Color.backgroundColor)
        .sheet(isPresented: $recipePageVM.isReplying) {
            Text("sheet")
        }
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
    private(set) var firebase: FirebaseViewModel
    @ObservedObject private(set) var recipePageVM: RecipePageViewModel
    @State var text = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Comments")
                .font(.custom("Welland",
                              size: 20))
                .foregroundColor(.sageGreen)
            Divider()
            
            ForEach(recipe.comments) { comment in
                CommentView(comment: comment,
                            recipePageVM: recipePageVM)
            }
            
            if recipePageVM.isReplying {
                Text("Replying to: \(recipePageVM.authorReplyingTo) ")
                    .font(.custom("Welland",
                                  size: 18))
                    .foregroundColor(.lightBlack)
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
        .padding()
    }
}

struct CommentView: View {
    private(set) var comment: Comment
    @ObservedObject private(set) var recipePageVM: RecipePageViewModel
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 30))
                Spacer()
            }
            VStack(alignment: .leading) {
                Spacer()
                Text(comment.author)
                    .font(.custom("Welland Bold",
                                  size: 18))
                    .foregroundColor(.lightBlack)
                Text(comment.text)
                    .font(.custom("Welland Semibold",
                                  size: 16))
                    .foregroundColor(.lightBlack)
            }
            Spacer()
            if !recipePageVM.isReplying {
                Image(systemName: "arrowshape.turn.up.left")
                    .font(.system(size: 20))
                    .onTapGesture {
                        recipePageVM.isReplying = true
                        recipePageVM.authorReplyingTo = comment.author
                        //print(recipePageVM.isReplying)
                    }
            } else {
                Image(systemName: "x.circle")
                    .font(.system(size: 20))
                    .onTapGesture {
                        recipePageVM.isReplying = false
                        recipePageVM.authorReplyingTo = comment.author
                    }
            }
        }
    }
}







struct RecipePage_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeViewModel()
        let firebase = FirebaseViewModel(recipeViewModel: recipe)
        RecipePage(recipe: Recipe(
            title: "",
            description: "",
            author: "",
            image: "",
            ingredients: [Ingredient](),
            directions: [Direction](),
            prepTime: 0,
            comments: [Comment(text: "testdsdsdsfsdffdfdsfds", author: "Author"),
                       Comment(text: "test1233", author: "Author2")])
        )
            .environmentObject(firebase)
    }
}
