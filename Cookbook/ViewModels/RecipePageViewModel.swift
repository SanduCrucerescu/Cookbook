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
//
//    var recipe: Recipe {
//        set {
//            _recipe = newValue
//        }
//        get { return _recipe }
//    }
    // completion: @escaping (_ value: Bool) -> Void
    func addCom(_ com: Comment) {
//        for ( i, cc ) in recipe!.comments.enumerated() {
//            if cc.text == com {
//                var ccc: Comment = cc
//                ccc.replies = com
//                recipe?.comments[i].replies = ccc.replies
//                print("3")
//            }
//        }
        
        if recipe!.comments.contains(com) {
            print("e")
        } else {
            
            print("a")
        }
    }
    
//    func getCom(_ commentsArray: Array<Comment>) -> Array<Comment> {
//        
//        var comm = commentsArray
//    
//        for (index, element) in comm.enumerated() {
//            if element.text == "subsubcommnet" {
//                var c = element
//                c.append(Comment(text: "aaa", author: "aaa"))
//                comm[index] = c
//                print("here")
//                //print(comm)
////                comm.append(Comment(text: "ssds", author: "sdssddddd"))
////                print(comm)
//            } else {
//                var array = getCom(element.replies)
//                
//                
////                array.append(Comment(text: "t", author: "t"))
//                
//                return comm
//            }
//        }
//        //comm.append(Comment(text: "", author: ""))
//        return comm
//    }
//    
//    func findID(_ c: Array<Comment>, completion: @escaping (_ value: Comment) -> Void){
//        completion(c[0])
//    }
}
