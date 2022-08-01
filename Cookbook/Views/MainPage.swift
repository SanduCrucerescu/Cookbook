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
            .contentView(viewRouter: viewRouter)
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
                    RoundedRectangle(cornerRadius: DrawingConstants.boxesCornerRadius)
                        .fill(.white)
                        .shadow(radius: DrawingConstants.boxesShadow)
                        .frame(
                            width: geo.size.width/DrawingConstants.otherBoxesWidthMultiplier ,
                            height: DrawingConstants.otherBoxesHeight)
                }
            }
        }
    }
}



struct MainPageContents_Previews: PreviewProvider {
    static var previews: some View {
        let viewRouter = ViewRouter()
        MainPage(viewRouter: viewRouter)
    }
}

