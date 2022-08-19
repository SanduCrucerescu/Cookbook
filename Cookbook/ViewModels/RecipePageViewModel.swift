//
//  RecipePageViewModel.swift
//  Cookbook
//
//  Created by Alex on 2022-08-16.
//

import Foundation

class RecipePageViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published private(set) var _isReplying: Bool = false
    @Published private(set) var _authorReplyingTo: String = ""
    @Published private(set) var _text = ""
    @Published private(set) var _nonExistingUser: Bool = false
    @Published private(set) var _error: Bool = false
    var commentID = ""
    
    
    init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
    var nonExistingUser: Bool {
        set { _nonExistingUser = newValue }
        get { return _nonExistingUser }
    }
    
    var error: Bool {
        set { _error = newValue }
        get { return _error }
    }
    
    var commentText: String {
        set { _text = newValue }
        get { return _text }
    }
    
    var isReplying: Bool {
        set { _isReplying = newValue }
        get { return _isReplying}
    }
    
    var authorReplyingTo: String {
        set { _authorReplyingTo = newValue }
        get { return _authorReplyingTo }
    }

    // completion: @escaping (_ value: Bool) -> Void
    
    func addComent(_ firebase: FirebaseViewModel) async {
        if !error {
            if isReplying && !commentText.isEmpty && nonExistingUser == false {
                print(commentID)
                for (index, comment) in recipe.comments.enumerated() {
                    if comment.id == commentID {
                        var commentTextArray = commentText.components(separatedBy: " ")
                        
                        commentTextArray.remove(at: commentTextArray.startIndex)
                        
                        let newCommentText = commentTextArray.joined(separator: " ")
                        
                        recipe.comments[index].replies.append(Comment(text: newCommentText, author: "test", replyingTo: authorReplyingTo))
                        firebase.addComment(recipe)
                    }
                }
            } else {
                recipe.comments.append(Comment(text: commentText, author: "tes2"))
                firebase.addComment(recipe)
            }
        }
    }
    
    func replyToComment(commentID: String, replyingTo: String){
        for (index, comment) in recipe.comments.enumerated() {
            if comment.id == commentID {
                recipe.comments[index].replies.append(Comment(text: commentText, author: "test", replyingTo: replyingTo))
                print(recipe.comments)
            }
        }
       
    }
    
}
