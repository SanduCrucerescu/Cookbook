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
                LoginView()
                    .environmentObject(viewRouter)
                    .environmentObject(firebase)
            case .MainPage:
                MainPage()
                    .environmentObject(viewRouter)
                    .environmentObject(recipeViewModel)
            case .Register:
                Register()
                    .environmentObject(viewRouter)
                    .environmentObject(firebase)
            case .AddRecipe:
                AddingRecipeView()
                    .environmentObject(viewRouter)
                    .environmentObject(recipeViewModel) 
        }
    }
}
