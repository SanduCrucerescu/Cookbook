//
//  MotherView.swift
//  Cookbook
//
//  Created by Alex on 2022-07-26.
//

import SwiftUI

struct MotherView: View {
    @ObservedObject var viewRouter: ViewRouter 
    @ObservedObject var recipeViewModel:RecipeViewModel
    @ObservedObject var firebase: FirebaseViewModel
    
    init(recipeViewModel: RecipeViewModel, viewRouter: ViewRouter) {
        self.recipeViewModel = recipeViewModel
        self.viewRouter = viewRouter
        self.firebase = FirebaseViewModel(recipeViewModel: recipeViewModel)
    }
    
    
    var body: some View {
        switch viewRouter.page {
            case .Login:
                LoginView(firebaseViewModel: firebase, viewRouter: viewRouter)
            case .MainPage:
                MainPage(viewRouter: viewRouter, recipes: recipeViewModel, firebaseViewModel: firebase)
            case .Register:
                Register(viewRouter: viewRouter, firebaseViewModel: firebase)
        }
    }
}
