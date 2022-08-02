//
//  CookbookApp.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI
import Firebase

@main
struct CookbookApp: App {
    @StateObject var viewRouter = ViewRouter()
    @StateObject var recipe = recipeViewModel()

    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MotherView(recipe: recipe, viewRouter: viewRouter)
        }
    }
}
