//
//  MainPageContents.swift
//  Cookbook
//
//  Created by Alex on 2022-07-30.
//

import SwiftUI

struct MainPage: View {

    private struct DrawingConstants{
        static let boxesCornerRadius: CGFloat = 15
        static let boxesShadow: CGFloat = 5
        static let popularBoxesWidth: CGFloat = 170
        static let populatBoxesHeight: CGFloat = 100
        static let lazyVStackHeight: CGFloat = 110
        static let otherBoxesWidthMultiplier: CGFloat = 1.05
        static let otherBoxesHeight: CGFloat = 110
        static let titleFont: CGFloat = 33
        static let subcategoriesFontSize: CGFloat = 30
    }


    @EnvironmentObject var recipes: RecipeViewModel
    @State private var search: String = ""

    var body: some View {
       NavigationView {
            GeometryReader { geo in
                ZStack {
                    ScrollView(showsIndicators: false){
                        LazyVStack(alignment: .leading) {
                            TagLineView()
                                .padding(.horizontal)
                            
                            TextField(
                                    "Search",
                                    text: $search)
                                .textFieldStyle(
                                    TextFieldDesign(
                                        image: "magnifyingglass",
                                        error: false,
                                        shadow: false))
                                .padding(.horizontal)

                            PopularRecipes()

                            LunchSubMenu()
                        }
                    }
                }
                .contentView(recipe: recipes, on: true)
                .ignoresSafeArea(.all, edges: .bottom)
                .background(Color.backgroundColor)
            }
            .navigationBarHidden(true)
        }
       .accentColor(.sageGreen)
       .navigationBarHidden(true)
       .navigationBarBackButtonHidden(true)
    }
    
    
    struct TagLineView: View {
        var body: some View {
            Text("Find the \nBest ")
                .foregroundColor(.sageGreen)
                .font(.custom("Welland",
                              size: DrawingConstants.titleFont))
            + Text("Recipes!")
                .underline()
                .font(.custom("Welland Bold",
                              size: DrawingConstants.titleFont))
                .foregroundColor(.darkSageGreen)
        }
    }
    
    
    struct PopularRecipes: View {
        @EnvironmentObject var recipes: RecipeViewModel
        
        var body: some View {
            Text("Popular Recipes")
                .font(.custom("ProximaNova-Regular",
                              size: DrawingConstants.subcategoriesFontSize))
                .frame(alignment: .leading)
                .padding(.horizontal)
                .foregroundColor(.sageGreen)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack{
                    ForEach(recipes.recipes) { recipe in
                        RecipeBox(recipe: recipe)
                    }
                }
            }
            .padding(.leading)
        }
    }


    struct LunchSubMenu: View {
        @EnvironmentObject var recipes: RecipeViewModel

        var body: some View {
            Text("Lunch")
                .foregroundColor(.sageGreen)
                .font(.custom("ProximaNova-Regular",
                              size: DrawingConstants.subcategoriesFontSize))
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack{
                    ForEach(recipes.recipes) { recipe in
                        RecipeBox(recipe: recipe)
                    }
                }
            }
            .padding(.leading)
        }

    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = RecipeViewModel()
        let firebase = FirebaseViewModel(recipeViewModel: recipe)
        Group {
            MainPage()
                .environmentObject(firebase)
                .environmentObject(recipe)
        }
    }
}

