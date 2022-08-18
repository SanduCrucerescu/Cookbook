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
    var commentID = ""
    
    
    init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
    var commentText: String {
        set {
            _text = newValue
        }
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
    
    func addComent() {
        if isReplying {
            print(commentID)
            for (index, comment) in recipe.comments.enumerated() {
                if comment.id == commentID {
                    recipe.comments[index].replies.append(Comment(text: commentText, author: "test", replyingTo: authorReplyingTo))
                    print(recipe.comments)
                }
            }
        } else {
            recipe.comments.append(Comment(text: commentText, author: "tes2"))
            print(recipe.comments)
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
