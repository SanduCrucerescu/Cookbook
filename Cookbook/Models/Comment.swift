//
//  Coments.swift
//  Cookbook
//
//  Created by Alex on 2022-08-14.
//

import Foundation

struct Comment: Identifiable, Codable, Equatable {
    
    var id = UUID().uuidString
    var text: String
    var author: String
    var replies: Array<Comment> = []
    var replyingTo: String?
    
    func conveertToDict() -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
        dict["text"] = self.text
        dict["author"] = self.author
        dict["replies"] = self.replies.reduce([String: Any]()) { (dict, comment) -> [String: Any]  in
            // var number = 1
            var dict = dict
            let comment1 = comment.conveertToDict()
            dict[comment.id] = comment1
            return dict
         }
        
        return dict
    }
    
//    func convertRepliesToDict() -> Dictionary<String, String> {
//
//    }

}
