//
//  MotherView.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

struct MotherView: View {
    @ObservedObject var viewRouter: ViewRouter 
    @ObservedObject var recipe:recipeViewModel
    @ObservedObject var firebase: FirebaseViewModel
    
    init(recipe: recipeViewModel, viewRouter: ViewRouter) {
        self.recipe = recipe
        self.viewRouter = viewRouter
        self.firebase = FirebaseViewModel(recipeViewModel: recipe)
    }
    
    
    var body: some View {
        switch viewRouter.page {
            case .Login:
                LoginView(firebaseViewModel: firebase, viewRouter: viewRouter)
            case .MainPage:
                MainPage(viewRouter: viewRouter, recipes: recipe, firebaseViewModel: firebase)
            case .Register:
                Register(viewRouter: viewRouter, firebaseViewModel: firebase)
        }
    }
}
