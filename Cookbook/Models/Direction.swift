//
//  Comment.swift
//  Cookbook
//
//  Created by Alex on 2022-08-08.
//

import Foundation

struct Direction: Identifiable, Codable{
    var id = UUID()
    var direction: String
    
    var dictionary: [String: Any] {
        return["direction": direction]
    }
}
