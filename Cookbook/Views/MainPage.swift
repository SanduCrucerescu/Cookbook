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
    
    
    @ObservedObject var viewRouter: ViewRouter
    @ObservedObject var recipes: recipeViewModel
    @ObservedObject var firebaseViewModel: FirebaseViewModel
    
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
        let geo: GeometryProxy
        var body: some View {
            Text("Other Recipes")
                .foregroundColor(.granola)
                .font(.title2)
                .padding(.horizontal)
                LazyVStack(){
                    ForEach(0..<50) { i in
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerRadius: DrawingConstants.boxesCornerRadius)
                                .fill(.white)
                                .shadow(radius: DrawingConstants.boxesShadow)
                            HStack(alignment: .top) {
                                Group{
                                    Image("köttbullar")
                                        .resizable()
                                        .frame(width: 120,height: 90, alignment: .leading)
                                        .layoutPriority(-1)
                                        .clipShape(RoundedRectangle(cornerRadius: DrawingConstants.boxesCornerRadius))
                                }.padding(.leading, 10)
                                VStack(alignment: .leading) {
                                    Text("Köttbullar")
                                        .font(.title3)
                                        .foregroundColor(.darkGrey)
                                        .bold()
                                    Text("Added by:")
                                        .font(.caption2)
                                        .foregroundColor(.lightGrey)
                                    Divider()
                                        .frame(width: geo.size.width/3,height: 2)
    
                                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum")
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



//struct MainPageContents_Previews: PreviewProvider {
//    static var previews: some View {
//        let viewRouter = ViewRouter()
//        let recipe = recipeViewModel()
//        MainPage(viewRouter: viewRouter, recipes: recipe)
//    }
//}

