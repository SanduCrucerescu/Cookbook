//
//  RecipePage.swift
//  Cookbook
//
//  Created by Alex on 2022-08-13.
//

import SwiftUI
import HalfASheet

struct RecipePage: View {
    
    private struct DrawingConstants {
        static var cornerRadius: CGFloat = 10
        static var menuOffSetY: CGFloat = -30.0
        static var sheetHeight: CGFloat = 0.40
        static var titleSize: CGFloat = 30
        static var descriptionSize: CGFloat = 18
        static var subPartsTitleSize: CGFloat = 20
        static var subPartsItemsSize: CGFloat = 18
        static var commentProfilePictureSize: CGFloat = 30
        static var replyImageSize: CGFloat = 20
        static var commentText: CGFloat = 16
    }
    
    
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
            
            HalfSheet(recipePageVM: recipePageVM, recipe: recipe)
        }
        .background(Color.backgroundColor)
        //MARK: IOS 16 change
//        .sheet(isPresented: $recipePageVM.isReplying) {
//            TextField("Comment", text: $text)
//                .textFieldStyle(TextFieldDesign(image: "", error: false, shadow: false))
//                //.presentationDetents([.fraction(0.15)])
//        }
    }

    struct HalfSheet: View {
        @State var text = ""
        @FocusState var y: Bool
        @ObservedObject private(set) var recipePageVM: RecipePageViewModel
        var recipe: Recipe
        
        var body: some View {
            HalfASheet(isPresented: $recipePageVM.isReplying, title: "Replying to \(recipePageVM.authorReplyingTo)") {
                
                VStack(alignment: .trailing) {
                    TextField("Comment", text: $text)
                        .focused($y)
                        .textFieldStyle(TextFieldDesign(image: "text.bubble",
                                                        error: false,
                                                        shadow: false,
                                                        height: 100))
                    Button {
                        //recipePageVM.comment.replies.append(Comment(text: "new", author: "new"))
                        
//                        let data = recipe.comments.flatMap{ $0 }
//                            .filter($0.text.range(of: recipePageVM.comment.text))
//
//                        print(recipe.comments.flatMap{ $0 }
//                            .filter($0.text.range(of: recipePageVM.comment.text)))
                        //print(recipePageVM.comment)
                        recipePageVM.recipe = recipe
                      //  recipePageVM.getCom()
                    } label: {
                        Text("Reply")
                    }
                    .buttonStyle(CustomButton(color: .white,
                                              height: 50,
                                              width: 100))
                    
                }
                
                
            }
            .height(.proportional(DrawingConstants.sheetHeight))
            .onAppear {
                y = true
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
                                  size: DrawingConstants.titleSize))
                    .foregroundColor(.lightBlack)
                Text("Author: \(recipe.author)")
                    .font(.custom("Welland Light",
                                   size: 15))
                     .foregroundColor(.lightBlack)
                
                Text(recipe.description)
                    .font(.custom("Welland",
                                  size: DrawingConstants.descriptionSize))
                    .foregroundColor(.lightBlack)
                
                Spacer()
                
                Text("Ingredients")
                    .font(.custom("Welland",
                                  size: DrawingConstants.subPartsTitleSize))
                    .foregroundColor(.sageGreen)
                ForEach(recipe.ingredients) { ingredient in
                    Text(ingredient.description)
                        .font(.custom("Welland",
                                      size: DrawingConstants.subPartsItemsSize))
                        .foregroundColor(.lightBlack)
                }
                    
                
                Spacer()

                Text("Description")
                    .font(.custom("Welland",
                                  size: DrawingConstants.subPartsTitleSize))
                    .foregroundColor(.sageGreen)
                ForEach(recipe.directions) { direction in
                    Text(direction.direction)
                        .font(.custom("Welland",
                                      size: DrawingConstants.subPartsItemsSize))
                        .foregroundColor(.lightBlack)
                }
            
                
            }
            .padding()
            .background(Color.backgroundColor)
            .cornerRadius(DrawingConstants.cornerRadius)
            .edgesIgnoringSafeArea(.bottom)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .offset(x: 0, y: DrawingConstants.menuOffSetY)
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
                                  size: DrawingConstants.subPartsTitleSize))
                    .foregroundColor(.sageGreen)
                Divider()
                
                VStack {
                    ForEach(recipe.comments) { comment in
                        CommentView(comment: comment,
                                    recipePageVM: recipePageVM,
                                    isReply: false,
                                    sizeIndendt: 0)
                        
                    }
                }
                
                
                TextField("Comment", text: $text)
                    .textFieldStyle(TextFieldDesign(image: "text.bubble",
                                                    error: false,
                                                    shadow: false))

                Button {
//                    self.recipe.comments.append(Comment(text: text, author: "text"))
//                    firebase.addComment(recipe)
//                    recipePageVM.recipe = recipe
                    
                    //var c = recipePageVM.getCom(recipe.comments)
//                    recipe.comments = c
                    
                    
                    
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
        var isReply: Bool
        @State var openSubComments: Bool = false
        @State var sizeIndendt: CGFloat
        var body: some View {
            VStack {
                HStack {
                    if isReply {
                        Spacer()
                            .frame(width: sizeIndendt)
                    }
                    VStack {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: DrawingConstants.commentProfilePictureSize))
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(comment.author)
                            .font(.custom("Welland Bold",
                                          size: DrawingConstants.subPartsItemsSize))
                            .foregroundColor(.lightBlack)
                        HStack{
                            Link("@\(comment.author)", destination: URL(string: "https://www.example.com")!)
                                .foregroundColor(.blue)
                            Text(comment.text)
                                .font(.custom("Welland Semibol",
                                              size: DrawingConstants.commentText))
                                .foregroundColor(.lightBlack)
                        }
                    }
                    Spacer()
                    Image(systemName: "arrowshape.turn.up.left")
                        .font(.system(size: DrawingConstants.replyImageSize))
                        .onTapGesture {
                            recipePageVM.isReplying = true
                            recipePageVM.authorReplyingTo = comment.author
                            recipePageVM.comment = comment
                            print(comment)
                    }
                }
                if openSubComments  {
                    ForEach(comment.replies) { replie in
                        CommentView(comment: replie,
                                    recipePageVM: recipePageVM,
                                    isReply: true,
                                    sizeIndendt: sizeIndendt + 30)
                    }
                }
                
                if openSubComments {
                    Button {
                        openSubComments = false
                    } label: {
                        Text("Hide")
                    }
                } else if comment.replies.count > 0 {
                    Button {
                        openSubComments = true
                        
                        print(sizeIndendt)
                    } label: {
                        Text("- Load \(Int(comment.replies.count)) replies" as String)
                    }
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
            comments: [Comment(text: "testdsdsdsfsdffdfdsfds", author: "Author",
                               replies: [Comment(text: "subcommnet", author: "123",
                                                 replies: [Comment(text: "subsubcommnet", author: "123")]),
                                         Comment(text: "ste", author: "ste")]),
                       Comment(text: "test1233", author: "Author2",
                               replies: [Comment(text: "subcommnet", author: "1233")])])
        )
            .environmentObject(firebase)
    }
}

