//
//  Coments.swift
//  Cookbook
//
//  Created by Alex on 2022-08-14.
//

import Foundation

struct Comment: Identifiable, Codable {
    var id = UUID().uuidString
    var text: String
    var author: String
    var replies: Array<Comment> = []
    
    func conveertToDict() -> Dictionary<String, String>{
        var dict = Dictionary<String, String>()
        dict["text"] = self.text
        dict["author"] = self.author
        return dict
    }
}
