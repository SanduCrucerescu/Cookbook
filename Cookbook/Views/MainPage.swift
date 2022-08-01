//
//  MainPageContents.swift
//  Cookbook
//
//  Created by Alex on 2022-07-30.
//

import SwiftUI

struct MainPage: View {
    @ObservedObject var viewRouter: ViewRouter
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading) {
                        Text("Popular Recipes")
                            .font(.title)
                            .frame(alignment: .leading)
                            .padding(.horizontal)
                            .foregroundColor(.white)
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack{
                                ForEach(0..<50) { i in
                                        ZStack {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(.white)
                                            .shadow(radius: 5)
                                        .frame(width: 170)
                                        Text("\(i)")
                                    }
                                }
                            }
                            .frame(height: 110)
                            .padding(.horizontal)
                        }
                        Divider()
                        Text("Other Recipes")
                            .foregroundColor(.white)
                            .font(.title2)
                            .padding(.horizontal)
                        
                            LazyVStack(){
                                ForEach(0..<50) { i in
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.white)
                                        .shadow(radius: 5)
                                        .frame(width: geo.size.width/1.05 , height: 110)
                                }
                            }
                            //.padding(.all)
                    }
                }
            }
            .contentView(viewRouter: viewRouter)
            .ignoresSafeArea(.all, edges: .bottom)
            .background(Image("LoginRegisterBackground").renderingMode(.original))
        }
    }
}



struct MainPageContents_Previews: PreviewProvider {
    static var previews: some View {
        let viewRouter = ViewRouter()
        MainPage(viewRouter: viewRouter)
    }
}
