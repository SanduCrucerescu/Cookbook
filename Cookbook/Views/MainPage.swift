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
    }


    @EnvironmentObject var recipes: RecipeViewModel
    @State private var search: String = ""

    var body: some View {
       NavigationView {
            GeometryReader { geo in
                ZStack {
                    //LazyVStack {
                        ScrollView(showsIndicators: false){
                            VStack(alignment: .leading) {
                                TagLineView()
                                    .padding(.horizontal)
                                
                                TextField(
                                        "Search",
                                        text: $search)
                                    .textFieldStyle(TextFieldDesign(image: "magnifyingglass", error: false))
                                    .padding(.horizontal)

                                PopularRecipes()

                                Text("Lunch")
                                    .foregroundColor(.granola)
                                    .font(.title2)
                                    .padding(.horizontal)
                                LazyVStack{
                                    ForEach(recipes.recipes) { recipe in
                                        OtherRecipes(recipe: recipe, geo: geo)
                                    }
                                }
                            }
                        }
                    }
                    .contentView(recipe: recipes)
                    .ignoresSafeArea(.all, edges: .bottom)
                    .background(Color.backgroundColor)
                    //.background(Image("LoginRegisterBackground").renderingMode(.original))
            }
            .navigationBarHidden(true)
        }
       .navigationBarHidden(true)
       .navigationBarBackButtonHidden(true)
    }

    struct TagLineView: View {
        var body: some View {
            Text("Find the \nBest ")
                .foregroundColor(.granola)
                .font(.system(size: 28, design: .default))
            + Text("Recipes!")
                .underline()
                .font(.system(size: 28, design: .default))
                .foregroundColor(.darkGranola)
        }
    }
    
    
    struct PopularRecipes: View {
        var body: some View {
            Text("Popular Recipes")
                .font(.title)
                .frame(alignment: .leading)
                .padding(.horizontal)
                .foregroundColor(.granola)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack{
                    ForEach(0..<50) { i in
                        VStack(alignment: .leading){
                            Image("köttbullar")
                                .resizable()
                                .frame(width: 210, height: 200 * (210/210 ))
                                .cornerRadius(10)
                            Text("Köttbullar")
                                .font(.title3)
                                .fontWeight(.bold)
                            Spacer()
                            HStack(spacing: 2) {
                                ForEach(0 ..< 5) { item in
                                        Image(systemName: "star")
                                    }
                                    Spacer()
                                    Text("$1299")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                
                            }
                        }
                        .frame(width: 210)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
                    }
                }
            }
            .padding(.leading)
        }
    }


    struct OtherRecipes: View {
        @EnvironmentObject var recipes: RecipeViewModel
        private(set) var recipe: Recipe
        private(set) var geo: GeometryProxy

        var body: some View {
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: DrawingConstants.boxesCornerRadius)
                        .fill(.white)
                        .shadow(radius: DrawingConstants.boxesShadow)
                    HStack(alignment: .top) {
                        CachedAsyncImage(url: URL(string: recipe.image), urlCache: .imageCache) { phase in
                            if let image = phase.image{
                                image
                                    .resizable()
                                    .frame(width: 120,height: 90, alignment: .leading)
                                    .layoutPriority(-1)
                                    .clipShape(RoundedRectangle(cornerRadius: DrawingConstants.boxesCornerRadius))
                                    .padding(.leading, 10)
                            } else {
                                ProgressView()
                                    .frame(width: 120,height: 90, alignment: .center)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(recipe.title)
                                .font(.title3)
                                .foregroundColor(.darkGrey)
                                .bold()
                            Text("Added by: \(recipe.author)")
                                .font(.caption2)
                                .foregroundColor(.lightGrey)
                            Divider()
                                .frame(width: geo.size.width/3,height: 2)

                            Text(recipe.description)
                                .font(.caption2)
                                .foregroundColor(.lightGrey)
                                .padding(.trailing, 30)
                        }

                        Spacer()
                        Button(action: {})
                            {
                                Image(systemName: "heart")
                                    .foregroundColor(.red)
                            }
                    }
                    .padding(.trailing, 10)
                }
                .frame(
                    width: geo.size.width/DrawingConstants.otherBoxesWidthMultiplier ,
                    height: DrawingConstants.otherBoxesHeight)
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

