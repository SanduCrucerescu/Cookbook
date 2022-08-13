//
//  Comment.swift
//  Cookbook
//
//  Created by Alex on 2022-08-08.
//

import Foundation

struct Direction: Identifiable, Hashable, Codable{
    var id = UUID().uuidString
    var direction: String
    
    var dictionary: [String: Any] {
        return["direction": direction]
    }
}
