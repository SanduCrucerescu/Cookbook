//
//  RecipePageViewModel.swift
//  Cookbook
//
//  Created by Alex on 2022-08-16.
//

import Foundation

class RecipePageViewModel: ObservableObject {
    var recipe: Recipe?
    @Published private(set) var _isReplying: Bool = false
    @Published private(set) var _authorReplyingTo: String = ""
    @Published var comment: Comment = Comment(text: "", author: "")
    

    var isReplying: Bool {
        set { _isReplying = newValue }
        get { return _isReplying}
    }
    
    var authorReplyingTo: String {
        set { _authorReplyingTo = newValue }
        get { return _authorReplyingTo }
    }
    
    func getCom(_ commentsArray: Array<Comment>) {
        for coments in commentsArray {
            if coments.text == "ste"{
                print("here")
            } else {
                getCom(coments.replies)
            }
        }
            
    }
    

    
    
    
    
}
