//
//  User.swift
//  Cookbook
//
//  Created by Alex on 2022-08-23.
//

import Foundation
import UIKit

struct User: Identifiable {
    var id = UUID().uuidString
    var username: String
    var description: String
    var imageURL: UIImage?
    var thumbnailPhotoURL: String?
}
