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
    @ObservedObject var recipePageVM: RecipePageViewModel
    
    init(_ recipe: Recipe) {
        self.recipe = recipe
        recipePageVM = RecipePageViewModel(recipe)
    }
    
    
    
    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false) {
//                CachedAsyncImage(url: URL(string: recipePageVM.recipe.image), urlCache: .imageCache) { phase in
//                    if let image = phase.image{
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .ignoresSafeArea(.all, edges: .top)
//                    } else {
//                        ProgressView()
//                    }
//                }
                Image(uiImage: recipe.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .ignoresSafeArea(.all, edges: .top)
                contents(recipe: recipePageVM.recipe,
                         firebase: firebase)
                CommentsSection(recipePageVM: recipePageVM)
                
            }
            .edgesIgnoringSafeArea(.top)
        }
        .background(Color.backgroundColor)
        //MARK: IOS 16 change
//        .sheet(isPresented: $recipePageVM.isReplying) {
//            TextField("Comment", text: $text)
//                .textFieldStyle(TextFieldDesign(image: "", error: false, shadow: false))
//                //.presentationDetents([.fraction(0.15)])
//        }
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
        
        
//        @State var recipe: Recipe
        @EnvironmentObject var firebase: FirebaseViewModel
        @ObservedObject private(set) var recipePageVM: RecipePageViewModel
        @FocusState private var isReplying: Bool
        
        
        var body: some View {
            VStack(alignment: .leading) {
                Text("Comments")
                    .font(.custom("Welland",
                                  size: DrawingConstants.subPartsTitleSize))
                    .foregroundColor(.sageGreen)
                Divider()
                
                VStack {
                    ForEach(recipePageVM.recipe.comments) { comment in
                        CommentView(comment: comment,
                                    recipePageVM: recipePageVM,
                                    isReply: false,
                                    replyFocusState: $isReplying,
                                    commentID: comment.id)
                        
                    }
                }
                
                
                TextField("Comment", text: $recipePageVM.commentText)
                    .focused($isReplying)
                    .textFieldStyle(TextFieldDesign(image: "text.bubble",
                                                    error: false,
                                                    shadow: false))
                    .onChange(of: recipePageVM.commentText) { newValue in
                        recipePageVM.commentText = newValue
                        var commentTextArray = recipePageVM.commentText.components(separatedBy: " ")
                        
                        //print(commentTextArray[0])
//
                        
                        if commentTextArray[0].hasPrefix("@") {
                            commentTextArray[0].remove(at: commentTextArray[0].startIndex)
                            
                            if commentTextArray[0] != recipePageVM.authorReplyingTo {
                                recipePageVM.nonExistingUser = true
                                recipePageVM.error = true
                                print("1")
//                                if commentTextArray[0].isEmpty {
//                                    recipePageVM.isReplying = false
//                                    print("2")
//                                }
                            } else {
                                recipePageVM.nonExistingUser = false
                                recipePageVM.isReplying = true
                                print("3")
                            }
                        } else {
                            recipePageVM.error = false
                            recipePageVM.isReplying = false
                            recipePageVM.authorReplyingTo = ""
                            print("4")
                        }

                    }

                Button {
//                    self.recipe.comments.append(Comment(text: text, author: "text"))
                    //firebase.addComment(recipe)
//                    recipePageVM.recipe = recipe
                    
                    //var c = recipePageVM.getCom(recipe.comments)
//                    recipe.comments = c
                    //DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    //isReplying = .on
                    //}
                    Task {
                        await recipePageVM.addComent(firebase)
                    }
                    
                    
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
        @State var sizeIndendt: CGFloat = 35
        var replyFocusState: FocusState<Bool>.Binding
        var commentID: String
        
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
                        VStack {
                            HStack(alignment: .firstTextBaseline) {
                                //Spacer()
                                Text(comment.author)
                                    .font(.custom("Welland Bold",
                                                  size: DrawingConstants.subPartsItemsSize))
                                    .foregroundColor(.lightBlack)
                                HStack{
                                    if comment.replyingTo != nil {
                                        Link("@\(comment.replyingTo ?? "")", destination: URL(string: "https://www.example.com")!)
                                            .foregroundColor(.blue)
                                    }
                                        
                                    }
                                    Text("  \(comment.text)")
                                        .font(.custom("Welland Semibol",
                                                      size: DrawingConstants.commentText))
                                        .foregroundColor(.lightBlack)
                                Spacer()
                            }
                            Spacer()
                            
                            HStack(alignment: .firstTextBaseline) {
                                Text("Reply")
                                    .foregroundColor(.lightGrey)
                                    .onTapGesture {
                                        replyFocusState.wrappedValue = true
                                        recipePageVM.isReplying = true
                                        recipePageVM.commentText = "@\(comment.author)  "
                                        recipePageVM.commentID = commentID
                                        recipePageVM.authorReplyingTo = comment.author
                                                                                
                                        print(recipePageVM.recipe.comments)
                                    }
                                Spacer()
                                }
                            Spacer()
                            }
                            
                        }
                    
                    }
                    if openSubComments  {
                        ForEach(comment.replies) { replie in
                            CommentView(comment: replie,
                                        recipePageVM: recipePageVM,
                                        isReply: true,
                                        replyFocusState: replyFocusState,
                                        commentID: comment.id)
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





struct RecipePage_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeViewModel()
        let firebase = FirebaseViewModel(recipeViewModel: recipe)
        RecipePage(Recipe(
            title: "",
            description: "",
            author: "",
            image: UIImage(imageLiteralResourceName: "köttbular"),
            ingredients: [Ingredient](),
            directions: [Direction](),
            prepTime: 0,
            comments: [Comment(id: "test", text: "testdsdsdsfsdffdfdsfds", author: "Author",
                               replies: [Comment(text: "subcommnet", author: "123", replyingTo: "test"),
                                         Comment(text: "subcommnet1", author: "123"),
                                         Comment(text: "subcommnet2", author: "123", replyingTo: "test")]),
                                                
                       Comment(text: "test1233", author: "Author2",
                               replies: [Comment(text: "subcommnet", author: "1233"),
                                         Comment(text: "subcommnet", author: "123"),
                                         Comment(text: "subcommnet", author: "123")])])
        )
            .environmentObject(firebase)
    }
}

