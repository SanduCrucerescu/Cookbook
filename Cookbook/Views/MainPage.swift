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
    
    
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var recipes: RecipeViewModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading) {
                        PopularRecipes()
                        Divider()
                        OtherRecipes(geo: geo)
                    }
                }
            }
            .contentView(viewRouter: viewRouter, recipe: recipes)
            .ignoresSafeArea(.all, edges: .bottom)
            .background(Image("LoginRegisterBackground").renderingMode(.original))
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
                            ZStack {
                                RoundedRectangle(cornerRadius: DrawingConstants.boxesCornerRadius)
                                .fill(.white)
                                .shadow(radius: DrawingConstants.boxesShadow)
                            .frame(
                                width: DrawingConstants.popularBoxesWidth,
                                height: DrawingConstants.populatBoxesHeight)
                            Text("\(i)")
                        }
                    }
                }
                .frame(height: DrawingConstants.lazyVStackHeight)
                .padding(.horizontal)
            }
        }
    }
    
    
    struct OtherRecipes: View {
        @EnvironmentObject var recipes: RecipeViewModel
        
        let geo: GeometryProxy
        var body: some View {
            Text("Other Recipes")
                .foregroundColor(.granola)
                .font(.title2)
                .padding(.horizontal)
                LazyVStack(){
                    ForEach(recipes.recipes) { i in
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerRadius: DrawingConstants.boxesCornerRadius)
                                .fill(.white)
                                .shadow(radius: DrawingConstants.boxesShadow)
                            HStack(alignment: .top) {
                                CachedAsyncImage(url: URL(string: i.image), urlCache: .imageCache) { phase in
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
                                    Text(i.title)
                                        .font(.title3)
                                        .foregroundColor(.darkGrey)
                                        .bold()
                                    Text("Added by: \(i.author)")
                                        .font(.caption2)
                                        .foregroundColor(.lightGrey)
                                    Divider()
                                        .frame(width: geo.size.width/3,height: 2)
    
                                    Text(i.description)
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
        }
    }
